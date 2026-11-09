#!/bin/sh
# Stamp a version name and code into config.xml, for CI builds.
#
#     bin/stamp-version.sh <version-name> <version-code>
#
# Both live as attributes of the <widget> element, which is the only place
# Cordova looks: ConfigParser.android_versionCode() reads the
# android-versionCode *attribute*, and a <preference> of that name is
# silently ignored. With no attribute to find, cordova-android falls back to
# deriving a code from the version name (PATCH + MINOR*100 + MAJOR*10000),
# which yields 0 for a non-numeric name like "main-abc1234" - and AGP then
# refuses to build: "versionCode is set to 0, but it should be a positive
# integer". So both are stamped here, and both are checked afterwards.
set -e

VERSION_NAME="${1:?Usage: stamp-version.sh <version-name> <version-code>}"
VERSION_CODE="${2:?Usage: stamp-version.sh <version-name> <version-code>}"

HERE="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"
CONFIG="$HERE/config.xml"

case "$VERSION_CODE" in
    ''|*[!0-9]*) echo "versionCode must be a positive integer, not '$VERSION_CODE'" >&2; exit 1 ;;
esac
[ "$VERSION_CODE" -gt 0 ] || { echo "versionCode must be greater than 0" >&2; exit 1; }

# Both substitutions are confined to the <widget> line, so the XML
# declaration's own version attribute on line 1 is left alone
sed -i \
    -e "/<widget /s|\bversion=\"[^\"]*\"|version=\"${VERSION_NAME}\"|" \
    -e "/<widget /s|\bandroid-versionCode=\"[^\"]*\"|android-versionCode=\"${VERSION_CODE}\"|" \
    "$CONFIG"

# A sed that matches nothing exits 0, so confirm both landed rather than
# building something that quietly kept the committed values
grep -q "<widget .*\bversion=\"${VERSION_NAME}\"" "$CONFIG" || {
    echo "Failed to stamp version=\"${VERSION_NAME}\" into $CONFIG" >&2
    exit 1
}
grep -q "<widget .*\bandroid-versionCode=\"${VERSION_CODE}\"" "$CONFIG" || {
    echo "Failed to stamp android-versionCode=\"${VERSION_CODE}\" into $CONFIG" >&2
    echo "Is the attribute still on the <widget> element?" >&2
    exit 1
}

grep '<widget ' "$CONFIG"
