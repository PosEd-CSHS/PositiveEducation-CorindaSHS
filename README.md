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
- `assets/fonts/` — self-hosted web fonts (`fonts.css` plus `.woff2` files), so pages render correctly on networks that block or filter Google Fonts
- `default.aspx` — root redirect to the public landing page
- `web.config` — IIS defaults with directory browsing disabled

QLearn remains the navigation hub for staff-facing content, so `staff/` has no landing page of its own — link directly to individual pages from QLearn. `public/index.aspx` is the entry point for everything under `public/`.

## Annual rollover

Update the year and four term date ranges in `assets/site-config.js`. Active games read their weekly schedule from this shared file, so the dates should not need to be edited separately in every game.

Then check that weekly content banks contain one entry for each teaching week. Wordle and Connections currently contain 40 entries.

## School server installation

The site is hosted from a SharePoint document library under
`/ourcurriculum/TeachingAndLearning/Documents/PosEd/`. Copy the contents of this
folder there without changing the `assets`, `public` or `staff` paths — every
page uses relative links, so the structure must stay intact.

**Pages must contain no server-side code.** SharePoint document libraries refuse
to render `.aspx` files containing `<% ... %>` blocks, including a leading
`<%@ Page %>` directive. Every page here is therefore plain static HTML with an
`.aspx` extension; the extension is kept because SharePoint renders `.aspx`
inline while it may force `.html` files to download instead. Do not reintroduce
a page directive — character encoding is handled by each page's own
`<meta charset="UTF-8">`.

`default.aspx` and `web.config` are **not used** in the SharePoint deployment
and are excluded from the upload package. They are retained here only for a
possible future move to a plain IIS site, where `default.aspx` would redirect
the root to `public/index.aspx` and `web.config` would disable directory
browsing and register the `.woff2` MIME type. Under SharePoint the public entry
point is `public/index.aspx` directly.

All fonts are served from `assets/fonts/`, so no page depends on Google Fonts or
any other external font service. If headings ever appear in a plain system font
rather than the condensed Bebas Neue face, check that the server is serving
`.woff2` files rather than returning 404 for them.

QLearn remains the intended navigation layer for direct staff links. This hides staff links from normal student navigation but does not create server-side authorisation, so staff pages must not contain confidential student information or sensitive records.

The character strengths survey submits the student's full name, house, homegroup, top five strengths, top strength and VIA comparison response to the configured school Microsoft Form. Keep the form ownership, permissions, retention and access settings under school control.

Alphabucks performs transparent local checks only: an answer must start with the weekly letter and cannot duplicate another answer. The facilitating teacher decides whether a response genuinely fits its category. No external AI service or API key is used.

## Use and maintenance

Before deployment, test the current-week label, one full game in each section, return links and score submission on the devices commonly used in Home Group rooms.
