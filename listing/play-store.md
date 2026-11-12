# Play Store listing — net.tutorweb.quiz (SmileyTutor)

## Main store listing

### App name

SmileyTutor

### Short description (≤ 80 characters)

Practise maths, build your skills and earn SmileyCoin rewards as you learn.

### Full description (≤ 4000 characters)

Build your maths skills, one question at a time.

SmileyTutor brings the tutor-web learning platform to an easier-to-use app. Designed for teenage students, it combines maths drills, quizzes and learning rewards to help you practise regularly and work towards a stronger understanding.

PRACTISE AT YOUR OWN PACE
Choose from the available maths topics, answer questions and keep working on areas you find challenging. Use SmileyTutor alongside your classes, for revision or for extra practice. 

LEARN THROUGH PRACTICE
Check your answers, learn from feedback and follow your progress. Repeated practice helps you move beyond remembering an answer towards understanding how to solve a problem. 

ACE DRILLSETS TO EARN REWARDS
SmileyTutor includes SmileyCoin (SMLY), a digital token used to reward learning achievements. Rewards add motivation to your practice and recognise your progress. Students use SmileyCoin to purchase essentials in SmileyStores run by SmileyCharity. 

BUILT ON EDUCATIONAL RESEARCH

SmileyTutor builds on tutor-web, a learning platform developed through years of educational research and classroom experience. Its focus is simple: giving students more opportunities to practise and learn. 

FREE TO USE, SUPPORTED BY ADS
SmileyTutor is free and contains advertising. Advertising revenue helps support the project and its educational work.

NO ACCOUNT NEEDED
SmileyTutor asks for no name, no email address and no sign-in. Start answering straight away.

Produced by SmileyCharity, this app is part of a wider effort to make learning opportunities more accessible.

Start with a topic, try a quiz and take the next step in your learning.

### App icon (512×512, 32-bit PNG with alpha)

    listing/smileytutor-icon.png

### Phone screenshots (min 2, max 8; JPEG or 24-bit PNG)

Should be 9:16 ratio (i.e. LG G6 without OS chrome)

    listing/screenshot.1.png
    listing/screenshot.2.png

### Category

* Apps → Education

### Tags (up to 5, optional)

* education, maths, tutoring, quiz, students

### Contact details
- **Email:** smileytutor.admin@gmail.com
- **Website:** http://www.tutor-web.net/

### External marketing opt-out

**TODO:** — decide whether Google may feature the app in its own
promotional placements; no signal either way in this repo.

## App content & policy declarations

### Privacy Policy URL

https://app-backend.smileytutor.is/privacy


### Ads declaration

Yes, this app contains ads

### Advertising ID declaration

**Yes** — the app uses the advertising ID (the
`com.google.android.gms.permission.AD_ID` permission is pulled in by
`admob-plus-cordova`) for the purpose of **advertising or marketing**.

NB the merged manifest also carries `ACCESS_ADSERVICES_TOPICS`,
`ACCESS_ADSERVICES_ATTRIBUTION` and `ACCESS_ADSERVICES_AD_ID`, likewise
from the SDK. Nothing in `src/twads.js` calls the Privacy Sandbox APIs,
and `tagForUnderAgeOfConsent: true` tells the SDK not to either — the
permissions are the SDK's, not a feature of this app.

### Content rating questionnaire (IARC)

Reference/Education/News-type app

Declare, because the questionnaire asks: the app contains advertising,
and it transfers a cryptocurrency (SmileyCoin) to a user-supplied wallet
address. It has no user-to-user communication, no user-generated content
shared between users, and no location sharing.

### Target audience and content

Age group = **13–17 (Teens)** only

(NB: "primarily appeals to children" implies u13)

Keeping u13 out of the target audience is what makes the AD_ID
declaration above acceptable; a Families/u13 audience would require
removing the advertising ID altogether.

### Data safety form

The app has no accounts and collects no contact details — see
`privacy.md` "What information does the Application obtain". Declare:

**Collected and shared with third parties**

| Category | Type | Purpose | Shared with |
|---|---|---|---|
| Device or other IDs | Device or other IDs (advertising ID) | Advertising or marketing | Google (AdMob) |
| Financial info | Other financial info (SmileyCoin wallet address) | App functionality | The public SmileyCoin blockchain |

**Collected, not shared**

| Category | Type | Purpose |
|---|---|---|
| App activity | Other actions (quiz answers, grades, coins earned) | App functionality; Analytics |
| App info and performance | Other app performance data (server-side request logs, incl. IP) | App functionality |

Notes for whoever fills the form in:

- The anonymous student UUID (`_student_uuid` in local storage, issued by
  `POST /register`) is a **collected** "Device or other ID" in Play's
  sense even though it identifies no device and no person — it is a
  persistent identifier the server stores. Declare it under *Device or
  other IDs* alongside the advertising ID, purpose *App functionality*,
  **not** shared.
- The wallet address is only collected if the user chooses to claim, so
  tick **"Data collection is optional"** for the Financial info row. The
  answers/grades rows are required, not optional.
- "Analytics" is the closest Play purpose for the anonymised educational
  research use the terms-of-use screen (`page_start.js:107`) describes.
  There is no analytics SDK in the app.
- **Encrypted in transit:** Yes — TLS to the backend (`install_nginx.sh`),
  and Google Play services for ads.
- **Users can request deletion:**
  https://app-backend.smileytutor.is/privacy#data-deletion
- Do **not** declare an email address or any other personal info. The
  login/JWT paths in `ajaxapi.js` belong to the Plone website build and
  are unreachable in an app build, where `twConfig.seedSubscriptions` is
  set (`www/start.html:42`, `usermenu.js:146`).

### App access

All functionality is available without any special access. There is no
login, no account and no paywall, so no test credentials are needed.

### Government apps / News apps / COVID-19 apps

Not applicable / No to all

### Financial features

The app transfers cryptocurrency, so the Financial features section does
apply. Declare: **"Cryptocurrency transfer or exchange"** is not quite
what the app does — it pays out an earned reward rather than offering
trading or custody — but there is no "rewards paid in cryptocurrency"
option, so this needs a decision rather than a guess:

**TODO:** confirm with Play support, or with the charity's legal
contact, which Financial features box SmileyCoin payouts belong in, and
whether a licence declaration is required in any distribution country.
The app holds no custody (no wallet is created or held for the user; the
user supplies an address and the backend sends to it) and takes no
payment from the user, which is the argument for the lightest
declaration available.

Raise one wrinkle with whoever answers that: an earned balance that is
never redeemed is **donated to the Education in a Suitcase project** once
the user has been inactive for 24 months, which is what the backend's
retention sweep does and what `privacy.md` now describes. It is the
behaviour tutor-web has always had — the redeem page has always said the
offer expires after two years — but "unclaimed value is reassigned to a
third party after a fixed period" is a term a reviewer may well treat as
more than a reward payout, and it slightly weakens the no-custody
argument above. Worth declaring rather than discovering.

* https://support.google.com/googleplay/android-developer/answer/9876821
* https://support.google.com/googleplay/android-developer/answer/13607354

## Store settings

### Free or paid

Free

### Countries/regions for distribution

All

**TODO:** "All" plus a cryptocurrency payout is worth a second look —
some jurisdictions restrict crypto distribution to minors. Resolve with
the Financial features TODO above.
