#!/usr/bin/env python3
"""
Fetch a @@quizdb-tutorial-dump and unpack it into a directory of JSON files.

The endpoint returns a flat {filename: content} manifest; this writes each
entry to that path beneath the output directory. Stdlib only.

The output directory is added to, not replaced, so several tutorials can be
fetched into one bundle a tutorial at a time. Questions are keyed by their
home lecture, which is often in another tutorial, so tutorials genuinely do
share directories. Nothing stale is cleaned up as a result: start from an
empty directory for a clean build.

Alongside the dump it maintains a subscriptions.json in the same shape
@@quizdb-subscriptions returns - a tree of tutorials and their lectures -
adding each tutorial as it is fetched.

Errors are reported, never written out. The dump streams, so a failure part
way through arrives as an "error.json" entry under a 200 rather than an HTTP
error - unpacking that alongside the rest would leave a bundle that looked
complete but wasn't. The response is checked before any of it is written.

  bin/fetch-tutorial.py https://example.com/math/math099.1/@@quizdb-tutorial-dump \
      --output www/seed --base https://tutorweb-quiz-app/
"""
import argparse
import json
import os
import ssl
import sys
import urllib.error
import urllib.parse
import urllib.request

ERROR_KEY = 'error.json'
SUBSCRIPTIONS = 'subscriptions.json'
PROG = os.path.basename(sys.argv[0]) or 'fetch-tutorial.py'


def die(msg):
    sys.stderr.write('%s: %s\n' % (PROG, msg))
    raise SystemExit(1)


def fetch(url, base=None, insecure=False, timeout=120):
    """Return the parsed dump, or die trying"""
    if base:
        sep = '&' if urllib.parse.urlparse(url).query else '?'
        url = url + sep + urllib.parse.urlencode(dict(base=base))

    context = None
    if insecure:
        context = ssl.create_default_context()
        context.check_hostname = False
        context.verify_mode = ssl.CERT_NONE

    try:
        with urllib.request.urlopen(url, timeout=timeout, context=context) as response:
            content_type = response.headers.get('Content-Type', '')
            body = response.read()
    except urllib.error.HTTPError as e:
        # The view answers errors as JSON when it hasn't started streaming
        detail = e.read().decode('utf-8', 'replace')
        try:
            parsed = json.loads(detail)
            detail = '%s: %s' % (
                parsed.get('error', e.reason),
                parsed.get('message', parsed.get('location', '')),
            )
        except ValueError:
            # Not a JSON error body. A Plone HTML error page is no use here,
            # so go with the status and reason; anything else might be.
            if 'html' in e.headers.get('Content-Type', ''):
                detail = e.reason
            else:
                detail = detail.strip()[:200] or e.reason
        die('HTTP %s from %s\n  %s' % (e.code, url, detail))
    except urllib.error.URLError as e:
        hint = ''
        if 'CERTIFICATE_VERIFY_FAILED' in str(e.reason):
            hint = '\n  (--insecure skips verification, for a self-signed test server)'
        die('could not reach %s\n  %s%s' % (url, e.reason, hint))

    if 'json' not in content_type:
        die('expected JSON from %s, got %r\n  %s' % (
            url, content_type, body[:200].decode('utf-8', 'replace').strip(),
        ))

    try:
        dump = json.loads(body.decode('utf-8'))
    except ValueError as e:
        # A dump cut off mid-stream won't parse, which is the point - it can't
        # be mistaken for a complete one
        die('invalid JSON from %s (truncated response?)\n  %s' % (url, e))

    if not isinstance(dump, dict):
        die('expected a JSON object from %s, got %s' % (url, type(dump).__name__))
    if not dump:
        die('empty dump from %s' % url)
    return dump


def report_server_error(dump):
    """Report an in-band error entry and exit, if there is one"""
    if ERROR_KEY not in dump:
        return
    err = dump[ERROR_KEY]
    lines = ['the server reported an error part way through the dump:']
    if isinstance(err, dict):
        for field in ('error', 'message', 'location'):
            if err.get(field):
                lines.append('  %s: %s' % (field, err[field]))
        if err.get('stacktrace'):
            lines.append('  stacktrace:')
            lines.extend('    ' + l for l in err['stacktrace'].splitlines())
    else:
        lines.append('  %r' % (err,))
    lines.append('%d entries arrived before it; none have been written.' % (
        len(dump) - 1,
    ))
    die('\n'.join(lines))


def safe_relative_path(key):
    """
    The key as a relative path, or None if it isn't one we'll write.

    Keys come off the network and become filesystem paths, so anything
    absolute, parent-relative or otherwise odd is refused rather than
    normalised into something surprising.
    """
    if not key or key != key.strip() or '\\' in key or '\0' in key:
        return None
    if key.startswith('/') or os.path.isabs(key) or ':' in key:
        return None
    parts = key.split('/')
    if any(p in ('', '.', '..') for p in parts):
        return None
    return os.path.join(*parts)


def subscription_entry(dump):
    """
    The @@quizdb-subscriptions node for the tutorial in this dump: its title,
    and a {uri, title} child per lecture in the order the dump lists them.

    NB: No 'uri' on the tutorial node. quizlib's lectureUrisFromSubscription()
    returns early for any node with one, so a tutorial carrying a uri would be
    taken for a lecture and its children never walked. 'id' is ignored by the
    client (and is what insertTutorial() sets), so identity goes there.
    """
    tutorials = [k for k, v in dump.items()
                 if isinstance(v, dict) and isinstance(v.get('lectures'), list)]
    if len(tutorials) != 1:
        die('expected one tutorial in the dump, found %d' % len(tutorials))
    key = tutorials[0]
    tutorial = dump[key]

    # Every URI is base + its own key, so the tutorial tells us the base and
    # we can look its lectures back up
    uri = tutorial.get('uri', '')
    if not uri.endswith(key):
        die('tutorial %s has uri %r, which does not end with its own name' % (key, uri))
    base = uri[:-len(key)]

    children = []
    for lecture_uri in tutorial['lectures']:
        if not lecture_uri.startswith(base):
            die('lecture %r is not under %s' % (lecture_uri, base))
        lecture = dump.get(lecture_uri[len(base):])
        if lecture is None:
            die('lecture %r is missing from the dump' % lecture_uri)
        children.append(dict(uri=lecture_uri, title=lecture.get('title', '')))

    return dict(id=key, title=tutorial.get('title', ''), children=children)


def write_subscriptions(entry, outdir):
    """
    Add this tutorial to subscriptions.json, replacing its own entry if it is
    already listed and leaving the other tutorials alone, so a bundle built up
    a tutorial at a time ends with all of them listed.
    """
    path = os.path.join(outdir, SUBSCRIPTIONS)
    subscriptions = dict(children=[])

    if os.path.exists(path):
        try:
            with open(path, encoding='utf-8') as f:
                subscriptions = json.load(f)
        except (ValueError, EnvironmentError) as e:
            die('could not read the existing %s\n  %s' % (path, e))
        if not isinstance(subscriptions, dict) or \
                not isinstance(subscriptions.get('children'), list):
            die('%s is not a subscriptions structure; move it aside' % path)

    # Replaced where it already appears, appended otherwise, so the order
    # tutorials were fetched in is the order they're offered in and
    # re-fetching one doesn't shuffle it to the end
    children = subscriptions['children']
    for i, child in enumerate(children):
        if isinstance(child, dict) and child.get('id') == entry['id']:
            children[i] = entry
            break
    else:
        children.append(entry)

    with open(path, 'w', encoding='utf-8') as f:
        json.dump(subscriptions, f, ensure_ascii=False, sort_keys=True)
        f.write('\n')

    return len(children)


def write_dump(dump, outdir, indent=None):
    """
    Write every entry beneath outdir, adding to whatever is already there.

    Entries this dump doesn't mention are left alone, so fetching a second
    tutorial fills the same directory rather than emptying it.
    """
    outdir = os.path.abspath(outdir)
    if os.path.exists(outdir) and not os.path.isdir(outdir):
        die('%s exists and is not a directory' % outdir)

    written = 0
    try:
        for key, content in sorted(dump.items()):
            path = os.path.join(outdir, safe_relative_path(key))
            directory = os.path.dirname(path)
            if directory and not os.path.isdir(directory):
                os.makedirs(directory)
            with open(path, 'w', encoding='utf-8') as f:
                json.dump(content, f, ensure_ascii=False, indent=indent,
                          separators=None if indent else (',', ':'), sort_keys=True)
                f.write('\n')
            written += 1
    except EnvironmentError as e:
        die('failed writing to %s after %d of %d entries\n  %s' % (
            outdir, written, len(dump), e,
        ))

    return outdir


def main(argv=None):
    parser = argparse.ArgumentParser(
        description='Fetch a @@quizdb-tutorial-dump into a directory of JSON files',
    )
    parser.add_argument('url', help='the @@quizdb-tutorial-dump endpoint')
    parser.add_argument('-o', '--output', default='seed',
                        help='directory to unpack into, added to rather than '
                             'replaced (default: seed)')
    parser.add_argument('-b', '--base',
                        help="root the app will serve the bundle from; passed to the "
                             "endpoint, which builds every URI as base + filename")
    parser.add_argument('--insecure', action='store_true',
                        help='skip TLS verification, for a self-signed test server')
    parser.add_argument('--timeout', type=int, default=120,
                        help='seconds to wait for the dump (default: 120)')
    parser.add_argument('--indent', type=int,
                        help='pretty-print with this indent, for inspecting a dump')
    parser.add_argument('-q', '--quiet', action='store_true')
    args = parser.parse_args(argv)

    dump = fetch(args.url, args.base, args.insecure, args.timeout)
    report_server_error(dump)

    unsafe = sorted(k for k in dump if safe_relative_path(k) is None)
    if unsafe:
        die('refusing to write entries named: %s' % ', '.join(repr(k) for k in unsafe[:5]))

    # Built before anything is written, so a dump we can't summarise doesn't
    # get half-unpacked first
    entry = subscription_entry(dump)

    outdir = write_dump(dump, args.output, args.indent)
    listed = write_subscriptions(entry, outdir)

    if not args.quiet:
        tutorials = sum(1 for k in dump if k.startswith('tutorials/'))
        questions = sum(1 for k in dump if k.startswith('questions/'))
        sys.stderr.write(
            '%s: wrote %d files to %s (%d tutorial/lecture, %d question)\n'
            '%s: %s lists %d tutorial(s); added %r with %d lecture(s)\n' % (
                PROG, len(dump), outdir, tutorials, questions,
                PROG, SUBSCRIPTIONS, listed, entry['title'], len(entry['children']),
            ))
    return 0


if __name__ == '__main__':
    sys.exit(main())
