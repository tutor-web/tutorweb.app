/*jslint nomen: true, browser: true */
/*global admob, document, window */
"use strict";

// AdMob interstitial bridge for the Cordova shell app.
//
// tutorweb.quiz is also deployed standalone (nginx, no Cordova), so this
// file lives in the wrapper repo rather than upstream: it's the seam
// between the two. window.twAds is always defined and safe to call; it
// no-ops when Cordova/admob-plus isn't present, and stays not-ready until
// an interstitial has actually finished preloading.
(function () {
    var AD_UNIT_ID = (window.twConfig || {}).adUnitIdAndroid;
    var interstitial = null;
    var isReady = false;

    function loadNext() {
        isReady = false;
        interstitial = new admob.InterstitialAd({ adUnitId: AD_UNIT_ID });
        interstitial.load().catch(function (e) {
            // admob.Events.interstitialLoadFail listener below retries
            console.warn("Ad load failed", e);
        });
    }

    document.addEventListener('deviceready', function () {
        if (typeof admob === 'undefined') {
            return; // Plugin not present on this platform/build
        }

        document.addEventListener(admob.Events.interstitialLoad, function () {
            isReady = true;
        });
        document.addEventListener(admob.Events.interstitialDismiss, loadNext);
        document.addEventListener(admob.Events.interstitialLoadFail, function () {
            setTimeout(loadNext, 30000); // Back off, then try preloading again
        });

        // All users of this app are teenagers (13-17), not general-audience
        // adults: request non-personalized, age-appropriate ads rather than
        // the SDK's default. Must be set before admob.start() so it applies
        // to the SDK's initial configuration.
        admob.configRequest({
            tagForChildDirectedTreatment: false, // COPPA "child-directed": app isn't aimed at under-13s
            tagForUnderAgeOfConsent: true, // disables personalised/behavioural ads for these users
            maxAdContentRating: 'T' // Teen
        }).then(function () {
            return admob.start();
        }).then(loadNext)['catch'](function (e) {
            console.warn("AdMob init failed", e);
        });
    }, false);

    window.twAds = {
        /** Show interstitial ad, return promise that resolves true iff ad successfully displayed */
        showInterstitial: function () {
            if (!isReady || !interstitial) {
                return Promise.resolve(false);
            }
            isReady = false;

            var currentAd = interstitial;
            return new Promise(function (resolve) {
                function onDismiss() {
                    document.removeEventListener(admob.Events.interstitialDismiss, onDismiss);
                    resolve(true);
                }
                document.addEventListener(admob.Events.interstitialDismiss, onDismiss);

                currentAd.show()['catch'](function () {
                    document.removeEventListener(admob.Events.interstitialDismiss, onDismiss);
                    loadNext();
                    resolve(false);
                });
            });
        }
    };
}());
