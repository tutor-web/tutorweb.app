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

PORTAL_ROOT="${PORTAL_ROOT:-https://tutor-web.net/}"
AD_UNIT_ID_ANDROID="${AD_UNIT_ID_ANDROID:-ca-app-pub-3940256099942544/1033173712}"

[ -d "$QUIZ_CHECKOUT" ] || git clone https://github.com/tutor-web/tutorweb.quiz "$QUIZ_CHECKOUT"
make -C "$QUIZ_CHECKOUT"

rm -rf "$WWW"
mkdir -p "$WWW"
cp -a "$QUIZ_RES"/*.css "$QUIZ_RES"/*.js "$QUIZ_RES"/*.jpg "$QUIZ_RES"/*.png "$WWW/"
cp -a "$HERE/src/"*.js "$WWW/"
rm -f "$WWW/tw.js.map.js"  # debug build artifact, not needed to ship

# Replace TWEXTRA with our configuration
for f in "${QUIZ_RES}/coin.html" "${QUIZ_RES}/quiz.html" "${QUIZ_RES}/start.html"; do
  sed "s|<!-- TWEXTRA -->|\\
  <script>twConfig = { portalRoot: '${PORTAL_ROOT}', adUnitIdAndroid: '${AD_UNIT_ID_ANDROID}' };</script>\\
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

# Allow hosting via. nginx too
chmod a+rX www/

echo "Synced $QUIZ_RES -> $WWW (portalRoot: $PORTAL_ROOT)"

[ -d "$HERE/platforms/android" ] || npx cordova platform add android

npx cordova build android
echo "Built $HERE/platforms/android/app/build/outputs/apk/debug/app-debug.apk"

if [ "$1" = "release" ]; then
  : "${ANDROID_KEYSTORE-$HERE/upload-keystore.jks}"
  : "${ANDROID_KEYSTORE_PASSWORD:?Set ANDROID_KEYSTORE_PASSWORD}"
  : "${ANDROID_KEY_ALIAS-smileytutor}"
  : "${ANDROID_KEY_PASSWORD-${ANDROID_KEYSTORE_PASSWORD}}"

  # Cordova only accepts signing credentials via a buildConfig JSON file, so
  # write one to a private tempfile rather than ever putting passwords in
  # the repo. Cleaned up on exit either way.
  BUILD_JSON="$(mktemp)"
  trap 'rm -f "$BUILD_JSON"' EXIT
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
fi
