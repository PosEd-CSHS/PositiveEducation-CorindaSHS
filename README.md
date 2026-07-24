# Positive Education — Corinda SHS

Internal resources supporting Corinda SHS Home Group activities.

## Delivery context

The QLearn course is the navigation hub and is accessible to teachers. Teachers display and facilitate selected activities collaboratively with a mixed-year Home Group class of approximately 28 students from Years 7–12.

Home Group runs for 10 minutes at the beginning of each school day. Resources should therefore be quick to open, simple to explain and suitable for a broad age range. Most activities do not require student information. The character strengths survey intentionally collects each student's full name, house and homegroup with their results so the Positive Education team can match and use the submissions.

## Repository structure

This branch (`school-server`) is organised for direct deployment to the school's IIS server, split by audience:

- `staff/games/` — official, once-a-week, leaderboard-linked Home Group games and `leaderboard.aspx`
- `staff/homegroup-lessons/` — fortnightly lesson and activity guidance
- `staff/staff-learning/` — staff PERMAH learning resource
- `staff/brain-breaks/` — quick movement and reset activities
- `staff/archive/` — retired resources retained for reference only
- `public/games/` — unlimited-practice duplicates of the four most popular games, with `public/index.aspx` as their landing page
- `public/character-strengths/` — character strengths directory and survey (open to anyone, no sign-in)
- `assets/site-config.js` — shared school-year dates and QLearn games hub link, used by every game in both sections
- `default.aspx` — root redirect to the public landing page
- `web.config` — IIS defaults with directory browsing disabled

QLearn remains the navigation hub for staff-facing content, so `staff/` has no landing page of its own — link directly to individual pages from QLearn. `public/index.aspx` is the entry point for everything under `public/`.

## Annual rollover

Update the year and four term date ranges in `assets/site-config.js`. Active games read their weekly schedule from this shared file, so the dates should not need to be edited separately in every game.

Then check that weekly content banks contain one entry for each teaching week. Wordle and Connections currently contain 40 entries.

## School server installation

Copy the contents of this folder into one IIS application or virtual directory without changing the `assets`, `public` or `staff` paths. ASP.NET must be enabled for `.aspx` files. The included `default.aspx` opens `public/index.aspx`, and `web.config` disables directory browsing.

QLearn remains the intended navigation layer for direct staff links. This hides staff links from normal student navigation but does not create server-side authorisation, so staff pages must not contain confidential student information or sensitive records.

The character strengths survey submits the student's full name, house, homegroup, top five strengths, top strength and VIA comparison response to the configured school Microsoft Form. Keep the form ownership, permissions, retention and access settings under school control.

Alphabucks performs transparent local checks only: an answer must start with the weekly letter and cannot duplicate another answer. The facilitating teacher decides whether a response genuinely fits its category. No external AI service or API key is used.

## Use and maintenance

Before deployment, test the current-week label, one full game in each section, return links and score submission on the devices commonly used in Home Group rooms.
