# Play Store listing — net.tutorweb.quiz (SmileyTutor)

Field-by-field worksheet for the Play Console "Main store listing" and "App
content" sections. Sourced from `config.xml`, `privacy.md`, the AdMob work
done in `src/twads.js`, and the submission checklist artifact
(https://claude.ai/artifact/RwfPgCzKE3yFpha7keSSgt). Where a value is already
fixed elsewhere in the repo it's filled in directly; everything else is
flagged **NEEDS INPUT**.

## Main store listing

### App name

SmileyTutor

### Short description (≤ 80 characters)
**NEEDS INPUT.** Draft to review/replace:
> Free maths drills and quizzes for students, from the SmileyCharity team.

(66 characters — leaves room to tune.)

### Full description (≤ 4000 characters)
**NEEDS INPUT.** `config.xml` only has the terse `<description>SmileyTutor
mathematics drills</description>` — expand this into real listing copy: what
the app does, who it's for (students, teens), the SmileyCoin
reward/motivation angle, that it's produced by SmileyCharity, and that it's
free and ad-supported. Keep it consistent with the Teen (13–17) audience
declared below — avoid copy that reads as aimed at young children.

### App icon (512×512, 32-bit PNG with alpha)

    listing/smileytutor-icon.png

### Phone screenshots (min 2, max 8; JPEG or 24-bit PNG)
**NEEDS INPUT.** Capture from a real signed build once the production AdMob
IDs are in (see build checklist). Suggested shots: start/home screen, an
active quiz, and the SmileyCoin reward screen.

### Category

* Apps → Education

### Tags (up to 5, optional)

* education, maths, tutoring, quiz, students

### Contact details
- **Email:** smileytutor.admin@gmail.com
- **Website:** http://www.tutor-web.net/

### External marketing opt-out
**NEEDS INPUT** — decide whether Google may feature the app in its own
promotional placements; no signal either way in this repo.

## App content & policy declarations

### Privacy Policy URL

https://github.com/tutor-web/tutorweb.app/blob/main/privacy.md

### Ads declaration

Yes, this app contains ads

### Advertising ID declaration

**Yes** — the app uses the advertising ID (the
`com.google.android.gms.permission.AD_ID` permission is pulled in by
`admob-plus-cordova`) for the purpose of **advertising or marketing**.

### Content rating questionnaire (IARC)

Reference/Education/News-type app

### Target audience and content

Age group = **13–17 (Teens)** only

(NB: "primarily appeals to children" implies u13)

### Data safety form

- Data collected: Device or other IDs (Advertising ID)
- Purpose: Advertising or marketing
- Shared with: Google (AdMob) as a third party
- Encrypted in transit: Yes (standard Google Play services)
- Users can request deletion: https://github.com/tutor-web/tutorweb.app/blob/main/privacy.md#Data-Deletion

Tutorweb also collects

- E-mail address to contact users
- Responses to questions and grades for lectures, which may be used anonymously for research

### App access

(Provide username/password for test account)

### Government apps / News apps / COVID-19 apps

Not applicable / No to all

### Financial features

TODO: SmileyCoin will need some kind of declaration:

* https://support.google.com/googleplay/android-developer/answer/9876821
* https://support.google.com/googleplay/android-developer/answer/13607354

## Store settings

### Free or paid

Free

### Countries/regions for distribution

All
