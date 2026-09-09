<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>PERMAH Wellbeing Audit — Corinda SHS</title>
<style>
  @import url('../../assets/fonts/fonts.css');

  :root {
    --green:  #1a4731;
    --green2: #235c3f;
    --gold:   #c9a227;
    --gold-lt:#f0d97a;
    --cream:  #faf7f0;
    --ink:    #1a1a1a;
    --muted:  #6b7280;
    --border: #e2ddd4;
    --white:  #ffffff;
  }

  *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
  body { font-family: 'Inter', sans-serif; background: var(--cream); color: var(--ink); min-height: 100vh; }

  header { background: var(--green); padding: 1.5rem 2rem; display: flex; align-items: center; gap: 1rem; }
  .logo-ring { width: 44px; height: 44px; border: 2px solid var(--gold); border-radius: 50%; display: flex; align-items: center; justify-content: center; flex-shrink: 0; }
  .logo-ring svg { width: 24px; height: 24px; fill: var(--gold); }
  header h1 { font-family: 'DM Serif Display', serif; color: var(--white); font-size: 1.2rem; line-height: 1.2; }
  header h1 span { display: block; font-family: 'Inter', sans-serif; font-size: 0.7rem; font-weight: 500; color: var(--gold-lt); letter-spacing: 0.08em; text-transform: uppercase; margin-bottom: 0.15rem; }

  main { max-width: 760px; margin: 0 auto; padding: 2rem 1.5rem 4rem; }

  .intro { background: var(--white); border: 1px solid var(--border); border-top: 4px solid var(--gold); border-radius: 8px; padding: 1.75rem 2rem; margin-bottom: 2rem; }
  .intro h2 { font-family: 'DM Serif Display', serif; font-size: 1.6rem; color: var(--green); margin-bottom: 0.5rem; }
  .intro p { color: var(--muted); font-size: 0.92rem; line-height: 1.6; }
  .intro p + p { margin-top: 0.5rem; }

  .stage-badge { display: inline-block; background: var(--green); color: var(--gold-lt); font-size: 0.68rem; font-weight: 700; letter-spacing: 0.1em; text-transform: uppercase; padding: 0.25rem 0.7rem; border-radius: 99px; margin-bottom: 0.75rem; }

  .role-options { display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; margin-top: 0.5rem; }
  .role-btn { border: 2px solid var(--border); border-radius: 10px; background: var(--white); padding: 1.5rem 1.25rem; cursor: pointer; text-align: center; transition: all 0.15s; font-family: 'Inter', sans-serif; }
  .role-btn:hover { border-color: var(--gold); transform: translateY(-2px); box-shadow: 0 4px 12px rgba(201,162,39,0.15); }
  .role-btn:focus-visible { outline: 2px solid var(--gold); outline-offset: 2px; }
  .role-btn:active { transform: translateY(0); }
  .role-btn-title { font-family: 'DM Serif Display', serif; font-size: 1.3rem; color: var(--green); margin-bottom: 0.4rem; }
  .role-btn-desc { font-size: 0.85rem; color: var(--muted); line-height: 1.5; }
  @media (max-width: 520px) { .role-options { grid-template-columns: 1fr; } }

  #survey { display: none; }

  .progress-wrap { margin-bottom: 2rem; }
  .progress-label { display: flex; justify-content: space-between; font-size: 0.8rem; color: var(--muted); margin-bottom: 0.4rem; }
  .progress-bar { height: 6px; background: var(--border); border-radius: 3px; overflow: hidden; }
  .progress-fill { height: 100%; background: var(--gold); border-radius: 3px; transition: width 0.4s ease; }

  .q-number { font-size: 0.7rem; font-weight: 600; color: var(--muted); letter-spacing: 0.08em; text-transform: uppercase; margin-bottom: 0.5rem; }
  .q-card { background: var(--white); border: 1px solid var(--border); border-radius: 8px; padding: 1.25rem 1.5rem; margin-bottom: 0.75rem; transition: border-color 0.2s, box-shadow 0.2s; }
  .q-card.rated { border-color: #c9a22760; box-shadow: 0 1px 6px rgba(201,162,39,0.12); }
  .q-text { font-size: 0.93rem; line-height: 1.6; margin-bottom: 1rem; color: var(--ink); }
  .rating-labels { display: flex; justify-content: space-between; font-size: 0.7rem; color: var(--muted); margin-bottom: 0.35rem; }
  .rating-options { display: flex; gap: 0.4rem; }
  .rating-btn { width: 42px; height: 42px; border-radius: 6px; border: 2px solid var(--border); background: var(--cream); font-size: 0.85rem; font-weight: 600; color: var(--muted); cursor: pointer; transition: all 0.15s; display: flex; align-items: center; justify-content: center; }
  .rating-btn:hover { border-color: var(--gold); color: var(--ink); }
  .rating-btn:focus-visible { outline: 2px solid var(--gold); outline-offset: 2px; }
  .rating-btn.selected { background: var(--green); border-color: var(--green); color: var(--white); }
  .rating-btn[data-val="5"].selected { background: var(--gold); border-color: var(--gold); color: var(--ink); }

  .submit-wrap { margin-top: 2.5rem; text-align: center; }
  .submit-btn { background: var(--green); color: var(--white); border: none; border-radius: 8px; padding: 0.9rem 2.5rem; font-size: 1rem; font-weight: 600; cursor: pointer; transition: background 0.2s, transform 0.1s; }
  .submit-btn:hover { background: var(--green2); }
  .submit-btn:active { transform: scale(0.98); }
  .submit-btn:disabled { opacity: 0.45; cursor: not-allowed; }
  .submit-note { font-size: 0.78rem; color: var(--muted); margin-top: 0.6rem; }

  #results { display: none; }
  .results-header { background: var(--green); color: var(--white); border-radius: 10px; padding: 2rem; margin-bottom: 2rem; text-align: center; }
  .results-header h2 { font-family: 'DM Serif Display', serif; font-size: 1.8rem; margin-bottom: 0.3rem; }
  .results-header p { font-size: 0.88rem; opacity: 0.85; }

  .profile-title { font-family: 'DM Serif Display', serif; font-size: 1.25rem; color: var(--green); margin-bottom: 0.9rem; }
  .pillar-row { display: flex; align-items: center; gap: 0.9rem; margin-bottom: 0.85rem; }
  .pillar-letter { width: 34px; height: 34px; border-radius: 50%; flex-shrink: 0; display: flex; align-items: center; justify-content: center; font-family: 'DM Serif Display', serif; font-size: 1.05rem; font-weight: 700; color: var(--white); }
  .pillar-main { flex: 1; min-width: 0; }
  .pillar-top { display: flex; justify-content: space-between; align-items: baseline; margin-bottom: 0.3rem; }
  .pillar-name { font-weight: 700; font-size: 0.92rem; }
  .pillar-band { font-size: 0.76rem; color: var(--muted); }
  .pillar-track { height: 8px; background: var(--border); border-radius: 4px; overflow: hidden; }
  .pillar-fill { height: 100%; border-radius: 4px; transition: width 0.5s ease; }

  .focus-box { background: var(--white); border: 1px solid var(--border); border-left: 5px solid var(--gold); border-radius: 10px; padding: 1.4rem 1.6rem; margin: 2rem 0 0.75rem; }
  .focus-eyebrow { font-size: 0.7rem; font-weight: 700; color: var(--gold); letter-spacing: 0.1em; text-transform: uppercase; margin-bottom: 0.3rem; }
  .focus-name { font-family: 'DM Serif Display', serif; font-size: 1.35rem; color: var(--green); margin-bottom: 0.6rem; }
  .focus-list { list-style: none; }
  .focus-list li { font-size: 0.9rem; line-height: 1.55; color: var(--ink); padding: 0.55rem 0; border-top: 1px solid var(--border); }
  .focus-list li:first-child { border-top: none; padding-top: 0; }

  .results-actions { margin-top: 2rem; text-align: center; display: flex; gap: 1rem; justify-content: center; flex-wrap: wrap; }
  .btn-outline { background: transparent; border: 2px solid var(--green); color: var(--green); border-radius: 8px; padding: 0.7rem 1.5rem; font-size: 0.9rem; font-weight: 600; cursor: pointer; transition: all 0.2s; }
  .btn-outline:hover { background: var(--green); color: var(--white); }

  @media (max-width: 520px) {
    main { padding: 1.25rem 1rem 3rem; }
    .rating-btn { width: 38px; height: 38px; font-size: 0.8rem; }
  }

  @media print {
    header { display: none !important; }
    main > *:not(#results) { display: none !important; }
    .results-actions { display: none !important; }
    #results { display: block !important; }
    body { background: white; }
    .results-header { background: white; color: var(--green); border: 1px solid var(--border); }
    .focus-box { break-inside: avoid; }
    .pillar-row { break-inside: avoid; }
  }
</style>
</head>
<body>

<header>
  <div class="logo-ring">
    <svg viewBox="0 0 24 24"><path d="M12 2l2.4 7.4H22l-6.2 4.5 2.4 7.4L12 17 5.8 21.3l2.4-7.4L2 9.4h7.6z"/></svg>
  </div>
  <h1><span>Corinda State High School</span>PERMAH Wellbeing Audit</h1>
</header>

<main>
  <!-- ROLE SELECT -->
  <div id="role-select">
    <div class="intro">
      <span class="stage-badge">Before you begin</span>
      <h2>Who's completing this audit?</h2>
      <p>The wording of a few questions is simplified for students, but the pillars, scoring and suggestions are exactly the same either way.</p>
    </div>
    <div class="role-options">
      <button class="role-btn" id="role-staff" type="button">
        <div class="role-btn-title">Staff</div>
        <div class="role-btn-desc">Standard wording.</div>
      </button>
      <button class="role-btn" id="role-student" type="button">
        <div class="role-btn-title">Student</div>
        <div class="role-btn-desc">Simpler, student-friendly wording.</div>
      </button>
    </div>
  </div>

  <!-- SURVEY -->
  <div id="survey">
    <div class="intro">
      <span class="stage-badge">24 questions, about 3 minutes</span>
      <h2>PERMAH Wellbeing Audit</h2>
      <p>Rate how true each statement is for you right now, from 1 (rarely true) to 5 (very true). Answer with how things actually are, not how you'd like them to be — there are no right or wrong answers.</p>
      <p id="privacy-note">Nothing is recorded or sent anywhere. Your answers and results stay in this browser tab only, and disappear when you close or refresh the page.</p>
    </div>
    <div class="progress-wrap">
      <div class="progress-label"><span>Your progress</span><span id="prog-text">0 of 24 answered</span></div>
      <div class="progress-bar"><div class="progress-fill" id="prog-fill" style="width:0%"></div></div>
    </div>
    <div id="audit-form"></div>
    <div class="submit-wrap">
      <button class="submit-btn" id="submit-btn" disabled>See my results</button>
      <p class="submit-note" id="submit-note">Answer all 24 questions to continue</p>
    </div>
  </div>

  <!-- RESULTS -->
  <div id="results">
    <div class="results-header">
      <h2 id="results-title">Your PERMAH Profile</h2>
      <p id="results-sub"></p>
    </div>

    <div class="profile-title">Your six pillars</div>
    <div id="pillar-rows"></div>

    <div id="focus-boxes"></div>

    <div class="results-actions">
      <button class="btn-outline" id="retake-btn">Retake audit</button>
      <button class="btn-outline" id="print-btn">🖨 Print / save as PDF</button>
    </div>
  </div>

  <p style="margin-top:3rem; font-size:0.72rem; color:var(--muted); line-height:1.6; text-align:center;">This audit was developed by Corinda State High School for reflective and pastoral care purposes. It is inspired by the PERMAH model of wellbeing (Seligman's PERMA, extended with Health) but is not a clinical or diagnostic tool. If you're finding things consistently difficult, talk to your Year Level Coordinator, a Guidance Officer, or a trusted adult — this audit is a conversation starter, not a substitute.</p>
</main>

<script>
/*
  Single-pass 24-item self-report: 4 items per PERMAH pillar, shuffled together
  so ratings aren't anchored by seeing a pillar's items grouped. Each item is
  1-5 ("rarely true" to "very true"); a pillar's score is the mean of its 4
  items (1.0-5.0). No ranking or head-to-head round needed here, unlike the
  character strengths survey — six independent pillar averages are the whole
  result, not a forced top-5.
*/
const PILLARS = [
  { id: 'P', name: 'Positive Emotion', color: '#c07820' },
  { id: 'E', name: 'Engagement',       color: '#2e6b9e' },
  { id: 'R', name: 'Relationships',    color: '#c75e8b' },
  { id: 'M', name: 'Meaning',          color: '#7b5ea7' },
  { id: 'A', name: 'Accomplishment',   color: '#3a7d44' },
  { id: 'H', name: 'Health',           color: '#1f8a8a' }
];

const CONTENT = {
  staff: {
    P: [
      'I feel genuinely good or content during an average day.',
      'Even on a hard day, I can usually find something to feel good about.',
      'I experience moments of joy, amusement or delight fairly often.',
      'Most weeks, I have more good moments than bad ones.'
    ],
    E: [
      'I get absorbed in what I’m doing, to the point of losing track of time.',
      'I have parts of my work or life that fully hold my attention.',
      'I feel energised, rather than drained, by how I spend most of my time.',
      'I regularly get to use the things I’m genuinely good at.'
    ],
    R: [
      'There are people in my life who genuinely care about me.',
      'I feel like I belong with the people around me, at work and outside it.',
      'I have someone I could turn to if I was having a hard week.',
      'I make time to actually connect with people who matter to me, not just coexist with them.'
    ],
    M: [
      'I feel like what I do matters, beyond just getting through the day.',
      'I have a clear sense of purpose in my life right now.',
      'I feel connected to something bigger than my own day-to-day routine.',
      'I know what I value, and my choices generally reflect that.'
    ],
    A: [
      'I regularly follow through on things I set out to do.',
      'I feel a sense of real progress toward goals that matter to me.',
      'I keep the commitments I make to myself, not just to other people.',
      'I feel capable when I take on something difficult.'
    ],
    H: [
      'I get enough sleep on most nights.',
      'I’m physically active in a way that feels good for my body.',
      'I eat and drink in ways that generally support how I feel, most days.',
      'I have ways of managing stress that actually work for me.'
    ]
  },
  student: {
    P: [
      'I feel genuinely happy or good during an average day.',
      'Even on a bad day, I can usually find something to feel okay about.',
      'I laugh or feel real joy fairly often.',
      'Most weeks, I have more good moments than bad ones.'
    ],
    E: [
      'I get so into something I’m doing that I lose track of time.',
      'I have things I do that fully hold my attention — school or not.',
      'I feel more energised than drained by how I spend most of my time.',
      'I regularly get to do things I’m actually good at.'
    ],
    R: [
      'There are people in my life who genuinely care about me.',
      'I feel like I belong with the people around me.',
      'I have someone I could go to if I was having a hard week.',
      'I actually spend time connecting with people who matter to me, not just being around them.'
    ],
    M: [
      'I feel like what I do matters, not just for marks or rules.',
      'I have a sense of what I’m working toward in my life right now.',
      'I feel connected to something bigger than my day-to-day routine.',
      'I know what I care about, and I try to act like it.'
    ],
    A: [
      'I regularly follow through on things I set out to do.',
      'I feel like I’m making real progress on things that matter to me.',
      'I keep the promises I make to myself, not just to other people.',
      'I feel capable when something is genuinely hard.'
    ],
    H: [
      'I get enough sleep on most nights.',
      'I move my body in a way that feels good, most weeks.',
      'I eat and drink in ways that generally help how I feel.',
      'I have things that actually help when I’m stressed.'
    ]
  }
};

const SUGGESTIONS = {
  P: [
    'Notice and name three good moments at the end of each day — writing them down works better than just thinking them.',
    'Build one small thing you enjoy into today, on purpose, rather than waiting to feel like it.',
    'Spend time on something that reliably makes you laugh — a person, a show, an activity — at least once this week.'
  ],
  E: [
    'Notice what you were doing the last time you lost track of time, and find a way to do more of it.',
    'Try using one of your strongest character strengths in a new setting this week — see the Character Strengths directory for ideas.',
    'Cut one low-engagement habit (scrolling, background TV) and swap the time for something that actually absorbs you.'
  ],
  R: [
    'Reach out to one person you care about this week — a message, not just a like, and something more specific than "how are you".',
    'Tell someone specifically what you appreciate about them — vague thanks lands differently to a specific one.',
    'If a relationship feels distant right now, pick one small, low-pressure way back in rather than waiting for a big moment.'
  ],
  M: [
    'Write one sentence on why something you did this week actually mattered — to you or to someone else.',
    'Find one small way to connect a task you find dull to something you actually care about.',
    'Spend ten minutes with something bigger than your day-to-day — nature, community, faith, creative work, whatever that is for you.'
  ],
  A: [
    'Pick one goal that’s genuinely yours (not set for you) and break it into a next step you could do this week.',
    'Finish one small thing you’ve been putting off — completion itself builds momentum for bigger goals.',
    'Notice one thing you’ve actually achieved recently before reaching for the next target — progress you don’t register doesn’t motivate you.'
  ],
  H: [
    'Pick one sleep habit to fix this week — a consistent wake time matters more than total hours for most people.',
    'Add one short burst of movement to a day that currently has none — it doesn’t need to be a workout to count.',
    'Identify what you actually do when stressed, and swap one unhelpful default (doomscrolling, skipping meals) for something that helps.'
  ]
};

let role = null;
let items = [];      // shuffled [{pillar, text}]
const answers = [];  // parallel to items, 1-5 or undefined
const TOTAL = 24;

function shuffle(arr) {
  for (let i = arr.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [arr[i], arr[j]] = [arr[j], arr[i]];
  }
  return arr;
}

function buildItems(r) {
  const list = [];
  PILLARS.forEach(p => {
    CONTENT[r][p.id].forEach(text => list.push({ pillar: p.id, text }));
  });
  return shuffle(list);
}

function startSurvey(r) {
  role = r;
  items = buildItems(role);
  answers.length = 0;
  document.getElementById('role-select').style.display = 'none';
  document.getElementById('survey').style.display = 'block';
  buildForm();
}

function buildForm() {
  const form = document.getElementById('audit-form');
  form.innerHTML = '';
  items.forEach((it, i) => {
    const card = document.createElement('div');
    card.className = 'q-card';
    card.id = `card-${i}`;
    card.innerHTML = `
      <div class="q-number">Question ${i + 1} of ${TOTAL}</div>
      <div class="q-text">${it.text}</div>
      <div class="rating-labels"><span>Rarely true</span><span>Very true</span></div>
      <div class="rating-options" role="group" aria-label="Question ${i + 1}">
        ${[1,2,3,4,5].map(n => `<button class="rating-btn" data-i="${i}" data-val="${n}" type="button">${n}</button>`).join('')}
      </div>`;
    card.querySelectorAll('.rating-btn').forEach(btn => {
      btn.addEventListener('click', () => handleAnswer(i, parseInt(btn.dataset.val)));
    });
    form.appendChild(card);
  });
}

function handleAnswer(i, val) {
  answers[i] = val;
  document.querySelectorAll(`.rating-btn[data-i="${i}"]`).forEach(btn => {
    btn.classList.toggle('selected', parseInt(btn.dataset.val) === val);
  });
  document.getElementById(`card-${i}`).classList.add('rated');
  updateProgress();
}

function updateProgress() {
  const count = answers.filter(a => a !== undefined).length;
  document.getElementById('prog-fill').style.width = (count / TOTAL * 100) + '%';
  document.getElementById('prog-text').textContent = `${count} of ${TOTAL} answered`;
  const done = count === TOTAL;
  document.getElementById('submit-btn').disabled = !done;
  document.getElementById('submit-note').textContent = done
    ? 'All answered — see your results'
    : `Answer all ${TOTAL} questions to continue (${TOTAL - count} remaining)`;
}

function bandFor(score) {
  if (score >= 4.0) return { label: 'Thriving', tone: 'strong' };
  if (score >= 3.0) return { label: 'Doing okay', tone: 'ok' };
  if (score >= 2.0) return { label: 'Worth some attention', tone: 'low' };
  return { label: 'A good place to start', tone: 'low' };
}

function computeScores() {
  const scores = {};
  PILLARS.forEach(p => {
    const vals = [];
    items.forEach((it, i) => { if (it.pillar === p.id && answers[i] !== undefined) vals.push(answers[i]); });
    scores[p.id] = vals.reduce((a, b) => a + b, 0) / vals.length;
  });
  return scores;
}

function showResults() {
  const scores = computeScores();
  document.getElementById('survey').style.display = 'none';
  document.getElementById('results').style.display = 'block';
  window.scrollTo({ top: 0, behavior: 'smooth' });

  document.getElementById('results-sub').textContent =
    role === 'student' ? 'How things are looking across your six pillars of wellbeing right now.'
                        : 'How things are looking across your six pillars of wellbeing right now.';

  const rows = document.getElementById('pillar-rows');
  rows.innerHTML = '';
  PILLARS.forEach(p => {
    const score = scores[p.id];
    const band = bandFor(score);
    const pct = (score - 1) / 4 * 100;
    const row = document.createElement('div');
    row.className = 'pillar-row';
    row.innerHTML = `
      <div class="pillar-letter" style="background:${p.color}">${p.id}</div>
      <div class="pillar-main">
        <div class="pillar-top">
          <span class="pillar-name">${p.name}</span>
          <span class="pillar-band">${score.toFixed(1)} / 5 — ${band.label}</span>
        </div>
        <div class="pillar-track"><div class="pillar-fill" style="width:${pct}%;background:${p.color}"></div></div>
      </div>`;
    rows.appendChild(row);
  });

  // Lowest pillar(s), ties within 0.1, capped at 2 so the takeaway stays focused.
  const sorted = [...PILLARS].sort((a, b) => scores[a.id] - scores[b.id]);
  const lowestScore = scores[sorted[0].id];
  const focusPillars = sorted.filter(p => scores[p.id] <= lowestScore + 0.1).slice(0, 2);

  const focusWrap = document.getElementById('focus-boxes');
  focusWrap.innerHTML = '';
  focusPillars.forEach(p => {
    const box = document.createElement('div');
    box.className = 'focus-box';
    box.style.borderLeftColor = p.color;
    box.innerHTML = `
      <div class="focus-eyebrow" style="color:${p.color}">Worth focusing on</div>
      <div class="focus-name">${p.name}</div>
      <ul class="focus-list">${SUGGESTIONS[p.id].map(s => `<li>${s}</li>`).join('')}</ul>`;
    focusWrap.appendChild(box);
  });
}

document.getElementById('role-staff').addEventListener('click', () => startSurvey('staff'));
document.getElementById('role-student').addEventListener('click', () => startSurvey('student'));
document.getElementById('submit-btn').addEventListener('click', showResults);
document.getElementById('print-btn').addEventListener('click', () => window.print());
document.getElementById('retake-btn').addEventListener('click', () => {
  document.getElementById('results').style.display = 'none';
  document.getElementById('role-select').style.display = 'block';
  window.scrollTo({ top: 0, behavior: 'smooth' });
});
</script>
</body>
</html>
