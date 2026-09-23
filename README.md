# TutorWeb Quiz — Cordova Android wrapper

Apache Cordova project that wraps the [tutorweb.quiz](https://github.com/tutor-web/tutorweb.quiz)
client-side app as an Android application.

## Installing build tools (Debian 13 "trixie")

None of this is installed on a fresh host. `/opt/android-sdk` is used as the
SDK location below; adjust if you'd rather keep it elsewhere. Get the current
command-line tools filename from
https://developer.android.com/studio#command-line-tools-only if the version
below is stale.

```sh
sudo apt update
sudo apt install -y nodejs npm openjdk-21-jdk-headless unzip curl
npm install

sudo apt install android-sdk gradle adb \
  google-android-cmdline-tools-19.0-installer \
  google-android-platform-36-installer
export ANDROID_HOME=/usr/lib/android-sdk
export ANDROID_SDK_ROOT=$ANDROID_HOME
npx cordova requirements android
npx cordova build android
```

Notes:
- `cordova-android@15` (pinned in `config.xml`) requires JDK 17 or 21, and
  targets `android-36` — hence those specific versions above.
- Use `npx cordova ...`, not a global `cordova` install, so the
  project-pinned version is used.
- Gradle itself needs no separate install — `cordova-android` uses the
  Gradle wrapper it generates under `platforms/android/`, which downloads
  the pinned Gradle version on first build.

## Building debug builds

The `bin/build.sh` generates a debug apk ready to install on a test device.

If not already present, a copy of the `tutorweb.quiz` repo will be checked out.

## Running on a real android device

### Access within an incus container

```sh
incus config device add ui-tutorweb-app lg-adb usb vendorid=1004 productid=633e
# NB: Revoke all USB debugging authorizations before connecting
```

### Installing

```sh
adb install platforms/android/app/build/outputs/apk/debug/app-debug.apk
adb logcat -t0 -s chromium:* CordovaLog:*
```
