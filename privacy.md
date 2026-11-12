# Privacy Policy

This privacy policy is applicable to the SmileyTutor app for mobile devices and web browsers, together with any related services operated by SmileyCharity (collectively, the "Application"). SmileyCharity is hereinafter referred to as the "Service Provider".

## Data Controller Information

SmileyCharity acts as the Data Controller responsible for the processing of your personal data.

*   Name: **TODO — the legal entity operating the app, which is not SmileyCharity the non-profit**
*   Address: **TODO — a full postal address**
*   Email: smileytutor.admin@gmail.com

For data protection inquiries and to exercise your GDPR rights, please contact the Data Controller using the contact information above.

## What information does the Application obtain and how is it used?

The Application has no accounts and no sign-in. It never asks for your name, email address, phone number, postal address or date of birth, and there is nothing in it you can type those into.

The first time you open the Application it asks you to accept these terms, and then registers an anonymous identifier with the Service Provider's server. From that point the Application holds:

*   **An anonymous identifier.** A random identifier (a "UUID") issued by the server on first run and stored on your device. It is not derived from your device, your hardware or anything about you, and it is not linked to any name or contact details. It is how the server recognises that two drills were answered by the same person. Registration is not optional: the Application needs the identifier and the drill settings issued alongside it in order to work at all. You can see it under "Your SmileyTutor ID" on the Application's SmileyCoin page, and you will need it to ask for your data to be deleted — see **Data Deletion**.
*   **Your drill settings.** A set of values drawn for you when you register, which control how questions are chosen and how your grade moves. They are fixed at registration so that a grade means the same thing throughout.
*   **Your answers and your grades.** For each question you answer: which question it was, when it was shown to you and when you answered, whether you were right, whether it was a practice question, the grade that followed, how many SmileyCoins it earned, and integrity hashes that let the server detect whether a record has been altered in transit.
*   **A SmileyCoin wallet address, if you choose to claim.** Only if and when you ask to be paid your SmileyCoins, and only the address you type in yourself. See **SmileyCoin payments** below.

### What it is used for

*   To run the Application: choosing your next question, working out your grade, and keeping your progress when you move between devices or reinstall.
*   To work out and pay the SmileyCoin your drills have earned.
*   For educational research, as the Application's terms of use state when you first open it. While you are using the Application the research works on aggregates; once you have been inactive for 24 months your answers are stripped of your identity and kept for research in that form — see **What is the data retention policy**. Research outputs describe groups of learners, never an individual.
*   To keep the service secure and to detect abuse of the SmileyCoin rewards.

The Service Provider does not send marketing communications, newsletters or promotional messages of any kind, and holds no contact details with which it could.

## Legal basis for processing your personal data

Where the GDPR applies, the Service Provider relies on the following lawful bases:

*   **Contract performance:** processing your anonymous identifier, drill settings, answers and grades in order to provide the Application you have asked to use, and to pay out SmileyCoin you have claimed.
*   **Legitimate interests:** maintaining network and information security, and preventing fraud and abuse of the SmileyCoin rewards. These interests are balanced against your rights, and because the Application's users are minors the balance is struck conservatively.
*   **Scientific research:** keeping your answers, with your identity removed from them, for educational research. Art 5(1)(b) of the GDPR treats further processing for scientific research as compatible with the purpose data was collected for, and Art 5(1)(e) permits it to be kept for longer on that basis, subject to the safeguards in Art 89(1). What those safeguards are in practice is set out under **What is the data retention policy**.
*   **Legal obligation:** to comply with laws, including retaining records of payments made where accounting law requires it.

The Service Provider does not rely on consent as a lawful basis for any processing, because it operates no consent-based features: there is no marketing, no analytics SDK, and no interest-based advertising. See **Advertising** below for how advertising is configured instead.

## Advertising

The Application is free and is supported by advertising delivered through Google AdMob.

Because every user of the Application is a minor, the Application instructs the AdMob SDK to treat all users as being under the age of consent. In practice this means:

*   Advertising is **non-personalised**. Ads are selected by context, not by a profile of you.
*   Behavioural targeting, interest-based targeting and remarketing are **disabled**.
*   Ad content is limited to a **Teen** maximum content rating.
*   Your data is not used to build an advertising profile, and is not sold or shared for cross-context behavioural advertising.

Non-personalised advertising still involves Google receiving your device's advertising identifier and IP address in order to deliver an ad, to cap how often you see the same one, and to detect invalid traffic. Google's handling of that data is governed by its own privacy policy, linked under **Third parties** below.

## Cookies and similar technologies

The Application stores your anonymous identifier and your progress in your device's local storage. This is strictly necessary for the Application to function — without it the Application cannot tell whose answers it is recording — and it is not used for tracking or advertising.

The AdMob SDK uses device identifiers for the non-personalised advertising described above.

The Application contains no analytics SDK and no third-party tracking pixels.

## SmileyCoin payments

The Application rewards progress with SmileyCoin (SMLY), a cryptocurrency. This part of the Application works differently from the rest, and the differences matter:

*   You earn SmileyCoin automatically as you cross grade boundaries. Nothing is collected from you in order to earn it.
*   To receive it, you must supply a SmileyCoin wallet address. Supplying one is entirely optional; you can use the Application indefinitely without ever claiming.
*   When you claim, the Service Provider records the wallet address you gave, the amount and the transaction identifier, and sends the payment over the SmileyCoin network.
*   **SmileyCoin transactions are recorded on a public blockchain.** That ledger is public, permanent, distributed across computers the Service Provider does not control, and cannot be edited or erased by the Service Provider or by anyone else. Once a payment is made, the wallet address, the amount and the time of the payment are public information for good.

Because of this, your right to erasure cannot extend to a payment already made. The Service Provider can delete its own record of your claim, but it cannot remove the transaction from the blockchain. Please consider this before supplying a wallet address — and in particular, avoid reusing a wallet address that is publicly connected to your name elsewhere.

Donating your balance to the Education in a Suitcase project, which the Application offers as an alternative, sends the payment to that project's wallet and records no address of yours.

### SmileyCoin you do not redeem

The Application tells you, on the redeem page, that you have a maximum of two
years to redeem what you have earned. What happens at that point:

*   **If you stop using the Application**, your record is anonymised after
    24 months of inactivity (see **What is the data retention policy**).
    Anything you had not redeemed by then is **donated to the Education in a
    Suitcase project** — the same destination the Application's own donate
    button offers. It is not quietly discarded, and it is not kept by the
    Service Provider. It has to be moved at that point rather than held,
    because afterwards there is no identity left that could claim it.
*   **If you ask for your data to be deleted**, any unredeemed balance is
    lost rather than donated, because deleting the answers removes the proof
    that it was earned. Redeem or donate your balance first if you want to
    keep it.

The reason a balance cannot simply be held for you indefinitely is that your
answers are the record of having earned it. Once those are deleted, there is
nothing left that could establish what you were owed.

A donation made this way is a real SmileyCoin transaction and is published on
the public blockchain like any other, but it carries the project's wallet
address rather than any address of yours.

## Automated decision-making

The Application makes two kinds of automated decision:

*   **Which question you are shown next**, chosen adaptively from how you have answered so far.
*   **How much SmileyCoin you have earned**, decided by whether your grade has crossed a boundary for the first time in a given lecture. The grade is recomputed on the server from your answers and your registered settings.

Neither produces a legal effect, and neither is a profile used for advertising or shared with anyone. If you believe an award has been decided wrongly, contact the Service Provider and a person will look at it. You have the right to express your point of view and to contest the outcome.

## Does the Application collect precise real time location information of the device?

No. The Application does not request location permission and does not gather precise location information. As with any internet service, your approximate region can be inferred from your IP address by the Service Provider's web server and by Google's advertising servers.

## Does the Application use Artificial Intelligence (AI) technologies?

No. The Application does not use artificial intelligence or machine learning to process your data or provide features. The adaptive question selection described under **Automated decision-making** is a fixed statistical algorithm published in educational research, not a trained model, and your answers are not used as training data for any AI system.

## What information does the Application collect automatically?

*   **The Service Provider's server** records your IP address in its web server logs, along with the request made and the time, as any web server does. The server does not collect your device model, operating system, browser type or any device identifier.
*   **Google AdMob** collects your device's advertising identifier, IP address, and information about your device and ad interactions, in order to deliver and measure the non-personalised advertising described above.

## Third parties

The Service Provider shares personal data with the following third parties, and only for the purposes stated:

| Third party | What it receives | Why |
|---|---|---|
| Google (AdMob) | Advertising identifier, IP address, device and ad interaction data | To deliver and measure non-personalised advertising |
| The SmileyCoin network | Your wallet address and the amount paid, published on a public blockchain | To pay out SmileyCoin you have claimed |
| **TODO — hosting provider** | Data in transit and at rest on the Application's server | To host the Application's server |

Third-party privacy policies:

*   [Google / AdMob](https://policies.google.com/technologies/partner-sites)

Your answers, grades and identifier are not sold, rented, or shared with advertisers, data brokers, or anyone else. They are used for educational research only after being anonymised and aggregated.

The Service Provider may additionally disclose information:

*   as required by law, such as to comply with a subpoena or similar legal process;
*   when it believes in good faith that disclosure is necessary to protect its rights, protect your safety or the safety of others, investigate fraud, or respond to a government request;
*   to trusted service providers who work on its behalf, do not have an independent use of the information disclosed to them, and have agreed to adhere to the rules set forth in this privacy statement.

Where the GDPR applies, the Service Provider enters into Data Processing Agreements (DPAs) with third-party service providers that process personal data on its behalf, as required by Article 28 of the GDPR.

## International Data Transfers

The Service Provider or its third-party service providers may transfer personal data outside the European Economic Area (EEA) — Google in particular processes advertising data in the United States. Where such transfers occur, the Service Provider will use an appropriate transfer mechanism required by GDPR Chapter V:

*   Adequacy decisions by the European Commission
*   Standard Contractual Clauses (SCCs) approved by the European Commission
*   Other safeguards or derogations recognized under GDPR Chapter V

Countries outside the EEA may not provide the same level of data protection as the EEA.

Note separately that the SmileyCoin blockchain is distributed worldwide and is not a transfer to a particular country or recipient; see **SmileyCoin payments**.

## What are my opt-out rights?

Because the Application has no account to close, the ways to stop it collecting anything are:

*   **Ask for your data to be deleted**, by email, quoting your SmileyTutor ID. See **Data Deletion** below.
*   **Uninstall the Application**, or stop using the website. This stops any further collection immediately. It does not delete what has already been sent, and once the Application is gone your identifier is gone with it, so neither you nor the Service Provider can find your records in order to delete them on request. After 24 months of inactivity your identity is removed from them automatically and your answers are kept for research (see **What is the data retention policy**), with any unredeemed SmileyCoin donated at that point. **If you want your answers deleted rather than anonymised, ask before uninstalling** — it cannot be done afterwards.
*   **Reset your device's advertising identifier**, or opt out of ad personalisation, in your device's own privacy settings. This affects what Google receives.
*   **Simply never claim.** No wallet address is recorded unless you choose to claim your SmileyCoin.

To exercise any other right, contact the data controller with the e-mail address at the top.

## What is the data retention policy and how can you manage your information?

| Data | Retained for |
|---|---|
| Your identifier, and the link between it and your answers | While you are using the Application, and for 24 months after the last time it contacted the server. Then removed — see below. |
| Your answers, grades and drill settings | Kept, under an identifier that is no longer yours, for educational research |
| Records of SmileyCoin payments (amount, wallet address, transaction id) | As long as required by applicable accounting and anti-fraud obligations, separately from the answers |
| Web server logs containing IP addresses | 14 days |

### After 24 months of inactivity, your record stops being yours

The Service Provider's server runs a nightly job over every user whose copy of the Application has not been in touch for 24 months. You do not have to ask for it and cannot opt out of it.

It does not delete what you answered. It takes your identity off it. Three things change at once:

*   **Your identifier is replaced** with a fresh one that belongs to nobody and cannot be used by anybody. No record is kept of which identifier it replaced, so there is nothing to join the two back together.
*   **The times are coarsened.** Each answer recorded the moment the question was put in front of you, to the second; that is rounded to the nearest day. How long you took over each question is kept, because that is what the research is about.

What survives is which questions were answered, whether each was right, the grade that followed and how long each took — a record of learning with the learner removed.

tutor-web exists to research how people learn, and the sequence of a student's answers is the thing being researched: which questions, in what order, right or wrong, and how the grade moved. Deleting it after two years would throw away the point of the project. Anonymising it keeps the learning and discards the learner.

The GDPR provides for this directly. Art 5(1)(b) treats further processing for scientific research as compatible with the purpose data was collected for, and Art 5(1)(e) permits data to be kept for longer where it will be processed solely for scientific research subject to the safeguards in Art 89(1). Removing the identifier, coarsening the times and rewriting the hashes are those safeguards.

### What this means for you

*   **Ask before two years are up, if you want deletion rather than this.** Once your record has been anonymised, neither you nor the Service Provider can find it: your identifier is gone and nothing maps the new one back to it.
*   **It cannot be reversed.** Coming back to the Application after more than 24 months away means starting from the beginning with a new identifier, and no way to recover your old progress.
*   **Any SmileyCoin you never redeemed is donated first**, rather than discarded — see **SmileyCoin payments**. It has to happen first, because afterwards there is no identity left that could claim it.
*   **Your payment record is kept apart from your answers.** Where you claimed SmileyCoin, the record of that payment stays for as long as accounting law requires, but it is not filed with the anonymised answers — so the wallet address you gave is not attached to the record of what you answered.

SmileyCoin transactions published to the blockchain are permanent and are not subject to any retention period the Service Provider can set; see **SmileyCoin payments**.

## Data Deletion

To have your data deleted, **email the data controller and include your SmileyTutor ID.** Your request will be processed within the timeframes required by applicable law.

You will find your SmileyTutor ID on the Application's SmileyCoin page, reached by "Redeem your smileycoins" in the menu.

After 24 months without the Application contacting the server, your identity is removed from your answers automatically and nothing maps the result back to you — so from that point there is nothing anybody can single out and delete. See **What is the data retention policy**.

### What cannot be deleted

Payments already made to the SmileyCoin blockchain cannot be deleted, by the Service Provider or by anyone else; see **SmileyCoin payments**. The Service Provider's own record of such a payment is kept for as long as accounting law requires, with the link to you removed.

## How does the Application address children's privacy?

The Application is intended for use by teenagers aged 13 to 17. It is not intended for, marketed to, or knowingly used by children under 13.

The Application does not ask your age, and therefore cannot verify it. Rather than relying on an age it cannot check, the Application applies the most protective settings to every user without exception:

*   Advertising is non-personalised for all users, with behavioural targeting and remarketing disabled and content limited to a Teen rating (see **Advertising**).
*   No name, email address, phone number or other contact detail is collected from anyone.
*   No analytics SDK, tracking pixel or advertising profile is used.
*   No marketing communications are sent, to anyone, ever.
*   No feature of the Application depends on consent, so no user — of any age — is asked to give a consent they may not be old enough to give, and no parental consent mechanism is needed for the Application to work.

The Service Provider does not knowingly collect personal data from children under 13. Because it collects no age and no identifying information, it cannot detect such a user; if it becomes aware of one, that user's data will be deleted promptly.

In the United Kingdom, the Application takes into account the standards of the ICO's Age Appropriate Design Code, given that all users of the Application are under 18.

If you are a parent or guardian and believe your teenager has provided information in a way that concerns you, or that a user under 13 is using the Application, please contact the Service Provider so that the necessary actions, including deletion, can be taken.

## How is your information kept secure?

The Service Provider implements physical, electronic, and procedural safeguards to protect the information it processes. Access by employees and contractors is limited to those who need it to operate, develop or improve the Application. Data in transit between the Application and the server is encrypted with TLS. No security system can prevent all potential security breaches.

You should also understand the following, which is a deliberate consequence of the Application having no accounts:

*   **Your anonymous identifier identifies you to the server, but it does not authenticate you.** There is no password. Anyone who obtained the identifier from your device could, in principle, read the answer history recorded under it and claim the SmileyCoin it has earned to a wallet of their own.
*   For this reason the identifier is treated as confidential: it is sent only over encrypted connections, and the Service Provider does not retain it in request logs during normal operation.
*   The records reachable this way are your drill answers, your grades and your SmileyCoin balance. They contain no name, contact details or payment credentials, because none are collected.

If you believe your identifier has been exposed, ask for your data to be deleted (see **Data Deletion**) and redeem any SmileyCoin you are owed first. Uninstalling and reinstalling issues you a new identifier, but leaves your old records in place under the old one — so ask for the deletion before you do that, while you still have the ID a request has to quote.

## Data Breach Notification

In the event of a personal data breach that poses a risk to your rights and freedoms, the Service Provider will notify the relevant supervisory authority within 72 hours of becoming aware of the breach, as required by applicable law.

Where the breach is likely to result in a high risk to your rights and freedoms, the Service Provider will also notify you without undue delay. Because no email address or other contact detail is held for anybody, this notice appears **inside the Application**: a message at the top of the page, on every screen, the next time you open it. It will say what happened, what kinds of data were affected and what is being done about it. You can dismiss it once you have read it, and if the message is later corrected or updated the new version appears again.

The same channel is used to tell you about material changes to this Privacy Policy.

## How will you be informed of changes to this Privacy Policy?

The Service Provider may update this Privacy Policy from time to time, and will post the updated version with a new effective date. The Application links to this policy from its menu and shows it before you first register.

Where a change is material, you will not have to go looking for it: a message appears at the top of the page inside the Application, as described under **Data Breach Notification**, the next time you open it.

Previous versions of this Privacy Policy are available in the version history of the repository this file lives in, and on request by contacting the Service Provider.

This privacy policy is effective as of 2026-11-11.

## What are your GDPR data protection rights?

Under the GDPR, you have the following rights:

*   **Right of Access:** You can request a copy of the data held under your anonymous identifier.
*   **Right to Rectification:** You can request correction of inaccurate data.
*   **Right to Erasure:** You can ask the Service Provider to delete your data, by email, quoting your SmileyTutor ID. The route and its limits are described under **Data Deletion**; in particular, payments already written to the blockchain cannot be erased by anyone.
*   **Right to Restrict Processing:** You can request that the Data Controller limits how it uses your data.
*   **Right to Data Portability:** You can request a copy of your data in a structured, commonly used, machine-readable format.
*   **Right to Object:** You can object to processing based on legitimate interests. You can also object to your answers being kept for scientific research under Art 21(6) — ask before the 24-month mark, because afterwards there is no record that can be identified as yours to act on.
*   **Right to Withdraw Consent:** The Service Provider does not rely on consent for any processing, so there is no consent to withdraw. If this changes, this policy will say so and a means of withdrawal will be provided in the Application.
*   **Rights Regarding Automated Decision-Making:** See **Automated decision-making** above.

Exercising any of these rights requires the Service Provider to be able to find your records, which means quoting your SmileyTutor ID and asking before your record is anonymised — see **Data Deletion** and **What is the data retention policy**. Art 89(2) of the GDPR allows these rights to be limited where data is kept for scientific research and the rights would make that research impossible; the Service Provider does not rely on that, because after anonymisation there is simply no longer a record it can connect to you.

If you believe your data protection rights have been violated, you have the right to lodge a complaint with your local Data Protection Authority. Contact details for each country's Data Protection Authority can be found at [https://edpb.ec.europa.eu/about-edpb/members_en](https://edpb.ec.europa.eu/about-edpb/members_en)

If you are located in the United Kingdom, you may contact the Information Commissioner's Office at [https://ico.org.uk](https://ico.org.uk)

## What are your California privacy rights (CCPA/CPRA)?

If you are a resident of California, the California Consumer Privacy Act (CCPA) and the California Privacy Rights Act (CPRA) provide you with additional rights regarding your personal information.

The Application does not sell personal information, and does not share it for cross-context behavioural advertising, for any user of any age. Behavioural and interest-based advertising is disabled for every user (see **Advertising**), so the question of opt-in consent for users under 16 — which the CCPA requires from the user if aged 13–15, and from a parent or guardian if under 13 — does not arise.

*   **Right to Know:** You can request disclosure of the categories and specific pieces of personal information collected about you.
*   **Right to Delete:** You can request deletion of personal information collected from you, subject to the exceptions described under **Data Deletion**.
*   **Right to Correct:** You can request correction of inaccurate personal information.
*   **Right to Opt-Out:** There is no sale or sharing for cross-context behavioural advertising to opt out of.
*   **Right to Limit Use of Sensitive Personal Information:** The Application does not collect sensitive personal information as the CPRA defines it.
*   **Right to Non-Discrimination:** The Service Provider will not discriminate against you for exercising any of your CCPA/CPRA rights.

To exercise any of these rights, contact the Service Provider. You may designate an authorized agent to make a request on your behalf.

## How can you contact the Data Controller?

If you have any questions regarding privacy while using the Application, please contact the Service Provider via email at smileytutor.admin@gmail.com.

The Service Provider will respond within one month of receiving your request, extendable by up to two months where necessary due to the complexity or volume of requests, as permitted by applicable law.
