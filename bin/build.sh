#!/bin/sh
# Build tutorweb.quiz, copy its client app into www/, then build the APK.
#
# tutorweb.quiz is the source of truth; this project just wraps its built
# output. Run this whenever you want to pick up upstream changes.
#
# Needs ANDROID_HOME/ANDROID_SDK_ROOT set - see README.md.
set -e

HERE="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"
QUIZ_CHECKOUT="$HERE/tutorweb.quiz"
QUIZ_RES="$QUIZ_CHECKOUT/tutorweb/quiz/resources"
WWW="$HERE/www"

BACKEND_ROOT="${BACKEND_ROOT:-https://app-backend.tutor-web.net/}"
AD_UNIT_ID_ANDROID="${AD_UNIT_ID_ANDROID:-ca-app-pub-3940256099942544/1033173712}"
# The endpoint used to sync lectures
SYNC_URI="${SYNC_URI:-/sync}"
TW_QUIZ_BRANCH="${TW_QUIZ_BRANCH:-anonymous-app}"

# Tutorials to bundle as seed content, so the app has drills before it has
# talked to a server. Space-separated portal paths, e.g.
#   SEED_TUTORIALS="math/math099.1 math/math100.1" bin/build.sh
# Empty (the default) builds without any, as before.
SEED_ROOT="${SEED_ROOT:-https://tutor-web.net/}"
SEED_TUTORIALS="${SEED_TUTORIALS:-}"
# Set for a test server with a self-signed certificate
SEED_INSECURE="${SEED_INSECURE:-}"
# Shared secret @@quizdb-tutorial-dump checks
export TW_DUMP_KEY="${TW_DUMP_KEY:-}"

# The subscription table fetch-tutorial.py maintains alongside the dumps. The
# app seeds itself from this on launch instead of asking the server for one,
# so it needs neither network nor login to offer the bundled tutorials. Unset
# without seed content, which leaves the app asking the server as before.
if [ -n "$SEED_TUTORIALS" ]; then
    SEED_SUBSCRIPTIONS="/subscriptions.json"
else
    SEED_SUBSCRIPTIONS=""
fi

[ -d "$QUIZ_CHECKOUT" ] || git clone --branch "$TW_QUIZ_BRANCH" https://github.com/tutor-web/tutorweb.quiz "$QUIZ_CHECKOUT"
make -C "$QUIZ_CHECKOUT"

rm -rf "$WWW"
mkdir -p "$WWW"
cp -a "$QUIZ_RES"/*.css "$QUIZ_RES"/*.js "$QUIZ_RES"/*.jpg "$QUIZ_RES"/*.png "$WWW/"
cp -a "$HERE/src/"*.js "$WWW/"
rm -f "$WWW/tw.js.map.js"  # debug build artifact, not needed to ship

# Replace TWEXTRA with our configuration
for f in "${QUIZ_RES}/coin.html" "${QUIZ_RES}/quiz.html" "${QUIZ_RES}/start.html"; do
  sed "s|<!-- TWEXTRA -->|\\
  <script>twConfig = { portalRoot: '${BACKEND_ROOT}', adUnitIdAndroid: '${AD_UNIT_ID_ANDROID}', seedSubscriptions: '${SEED_SUBSCRIPTIONS}', syncUri: '${SYNC_URI}' };</script>\\
  <script src='cordova.js'></script>\\
  <script src='twads.js'></script>\\
  |" "$f" > "${WWW}/$(basename "$f")"
done

# Copy the mathjax/ files the app actually uses, per tutorweb.quiz's own
# lib-sw/010-mathJaxResources.js manifest
grep -o '"mathjax/[^"?]*' "$QUIZ_CHECKOUT/lib-sw/010-mathJaxResources.js" | sed 's/^"mathjax\///' | sort -u |
while IFS= read -r rel; do
    mkdir -p "$WWW/mathjax/$(dirname "$rel")"
    cp "$QUIZ_RES/mathjax/$rel" "$WWW/mathjax/$rel"
done

# Fetch each tutorial's seed content into one shared directory. Questions are
# keyed by their home lecture, which is often in a different tutorial, so the
# dumps deliberately share directories and must not be unpacked separately.
if [ -n "$SEED_TUTORIALS" ]; then
    command -v python3 >/dev/null || {
        echo "python3 is needed to fetch seed content (SEED_TUTORIALS is set)" >&2
        exit 1
    }
    for tutorial in $SEED_TUTORIALS; do
        # NB: fetch-tutorial.py exits non-zero on a partial dump, and set -e
        # means that fails the build rather than shipping half a tutorial
        "$HERE/bin/fetch-tutorial.py" \
            "${SEED_ROOT%/}/${tutorial}/@@quizdb-tutorial-dump" \
            --output "$WWW" \
            --base "/" \
            ${SEED_INSECURE:+--insecure}
    done
    echo "Seeded $SEED_TUTORIALS -> $WWW (base: /)"
fi

# Allow hosting via. nginx too
chmod a+rX www/

echo "Synced $QUIZ_RES -> $WWW (portalRoot: $BACKEND_ROOT, syncUri: ${SYNC_URI:-<lecture>})"

[ -d "$HERE/platforms/android" ] || npx cordova platform add android

# Cordova only accepts signing credentials via a buildConfig JSON file,
# write it to a temporary directory that gets cleaned up afterwards
BUILD_DIR="$(mktemp -d)"
trap 'rm -rf "$BUILD_DIR"' EXIT

# Use a shared debug keystore in CI builds
DEBUG_KEYSTORE="${DEBUG_KEYSTORE:-$HERE/debug-keystore.jks}"
if [ -f "$DEBUG_KEYSTORE" ]; then
    cat > "$BUILD_DIR/debug.json" <<JSON
{
  "android": {
    "debug": {
      "keystore": "$DEBUG_KEYSTORE",
      "storePassword": "android",
      "alias": "androiddebugkey",
      "password": "android",
      "keystoreType": "jks"
    }
  }
}
JSON
    npx cordova build android --buildConfig="$BUILD_DIR/debug.json"
else
    echo "No $DEBUG_KEYSTORE; Gradle will sign with a per-machine debug key" >&2
    npx cordova build android
fi
echo "Built $HERE/platforms/android/app/build/outputs/apk/debug/app-debug.apk"

if [ "$1" = "release" ]; then
  : "${ANDROID_KEYSTORE-$HERE/upload-keystore.jks}"
  : "${ANDROID_KEYSTORE_PASSWORD:?Set ANDROID_KEYSTORE_PASSWORD}"
  : "${ANDROID_KEY_ALIAS-smileytutor}"
  : "${ANDROID_KEY_PASSWORD-${ANDROID_KEYSTORE_PASSWORD}}"

  BUILD_JSON="$BUILD_DIR/release.json"
  cat > "$BUILD_JSON" <<JSON
{
  "android": {
    "release": {
      "keystore": "$ANDROID_KEYSTORE",
      "storePassword": "$ANDROID_KEYSTORE_PASSWORD",
      "alias": "$ANDROID_KEY_ALIAS",
      "password": "$ANDROID_KEY_PASSWORD"
    }
  }
}
JSON

  npx cordova build android --release --buildConfig="$BUILD_JSON" -- --packageType=bundle
  echo "Built $HERE/platforms/android/app/build/outputs/bundle/release/app-release.aab"

  # And an APK signed with the same key. The bundle is a Play upload format
  # that cannot be installed on a device, so without this a tagged release
  # has nothing anyone can actually run.
  npx cordova build android --release --buildConfig="$BUILD_JSON" -- --packageType=apk
  RELEASE_APK="$HERE/platforms/android/app/build/outputs/apk/release/app-release.apk"
  # Gradle emits app-release-unsigned.apk instead when the signing config did
  # not take, which is worth failing on rather than shipping unsigned
  [ -f "$RELEASE_APK" ] || {
      echo "No signed APK at $RELEASE_APK - did the signing config apply?" >&2
      ls -l "$(dirname "$RELEASE_APK")" >&2 || true
      exit 1
  }
  echo "Built $RELEASE_APK"
fi
