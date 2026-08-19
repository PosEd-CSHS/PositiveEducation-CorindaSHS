# Special editions

One-off game editions for specific events or theme weeks — Book Week, and
whatever comes after it. These sit apart from the Home Group games in
`games/`: no weekly Home Group lock, no Microsoft Form submission, no
leaderboard tie-in. Anyone can open the page and play any number of times.
Because they're plain files on `main`, publishing one is just committing it —
GitHub Pages serves it immediately, with no SharePoint upload step.

## Where's Smoulder — Book Week (`smoulder-book-week.html`)

Same crowd-of-students engine as `games/smoulder.html`, with the game's own
existing single-themed-prop mechanism (previously used for one date-gated
weekly extra, e.g. the Book Week 📚 stack that still shows up in the regular
game in term 3 week 7) generalised into an `EVENT_EXTRAS` array that can hold
any number of extras, always on, not date-gated.

To make another event's edition:

1. Copy `smoulder-book-week.html` to a new file (e.g. `smoulder-harmony-day.html`).
2. Edit only the `EVENT_CONFIG` block near the top of the `<script>` — the
   `EVENT_NAME` and `EVENT_EXTRAS` array. Each entry is either:
   - `kind:'prop'` — a small canvas-drawn icon. Write a `drawX(x,y,s)`
     function next to the existing Book Week ones (`drawOpenBook`,
     `drawWizardHat`, `drawDragon`, `drawOwl`, `drawWand`) and point `draw` at
     it.
   - `kind:'image'` — a PNG/JPG instead of code. Set `src` to a same-origin
     image path or a `data:` URI; the generic `drawImageProp` function
     composites it, no new drawing code needed.
3. Use `tools/smoulder-character-calibrator.html` to tune each entry's
   `yOff`/`topRise`/`scale` against the actual crowd size range (26–80px)
   instead of guessing and reloading the real game repeatedly. It prints a
   config line ready to paste in.
4. Update the `<title>`, `<h1>`, intro paragraph and the extra `instr-card`
   in the instructions panel so the page describes its own event instead of
   Book Week.
5. Leave the permanent cast (chickens, alpacas, the six house mascots,
   Smoulder the Phoenix, Mr Bailey, farmer, scientist, drummer, soccer
   player, dancer) and everything below `EVENT_CONFIG` alone — that's the
   shared engine, not per-event content.

Deliberately removed from this template, unlike the regular Home Group
Smoulder: the once-per-week Home Group lock, the Microsoft Form score
submission, and the "see where your house is sitting" leaderboard link. A
special edition is for fun, played on demand — it doesn't feed the official
Home Group scoring data. If a future event genuinely needs scores collected,
that's a deliberate decision to wire back in, not a default.
