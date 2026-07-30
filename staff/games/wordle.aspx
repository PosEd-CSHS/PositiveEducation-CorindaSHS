<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-Frame-Options" content="ALLOWALL">
<meta name="referrer" content="no-referrer">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Wordle — CSHS</title>
<style>
  @import url('../../assets/fonts/fonts.css');

  :root {
    --green: #00180f;
    --green-mid: #003d1f;
    --green-light: #005a2e;
    --gold: #f2b400;
    --gold-dim: rgba(242,180,0,0.15);
    --gold-border: rgba(242,180,0,0.3);
    --white: #fdfdfd;
    --muted: rgba(255,255,255,0.55);
    --danger: #e05252;
    --correct: #4caf7a;
    --present: #e6a817;
    --absent: rgba(255,255,255,0.12);
  }

  * { box-sizing: border-box; margin: 0; padding: 0; }

  body {
    font-family: 'DM Sans', sans-serif;
    background: var(--green);
    color: var(--white);
    min-height: 100vh;
    overflow-x: hidden;
  }

  body::before {
    content: '';
    position: fixed;
    inset: 0;
    background:
      radial-gradient(ellipse 80% 50% at 20% 0%, rgba(0,90,46,0.4) 0%, transparent 60%),
      radial-gradient(ellipse 60% 40% at 80% 100%, rgba(242,180,0,0.08) 0%, transparent 60%);
    pointer-events: none;
    z-index: 0;
  }

  .container {
    max-width: 680px;
    margin: 0 auto;
    padding: 24px 16px;
    position: relative;
    z-index: 1;
  }

  /* ── Header ── */
  .header { text-align: center; margin-bottom: 28px; }
  .header-eyebrow {
    font-family: 'DM Mono', monospace;
    font-size: 10px;
    letter-spacing: 0.2em;
    color: var(--gold);
    text-transform: uppercase;
    margin-bottom: 8px;
  }
  .header h1 {
    font-family: 'Bebas Neue', sans-serif;
    font-size: clamp(52px, 12vw, 96px);
    color: var(--white);
    letter-spacing: 0.05em;
    line-height: 0.9;
  }
  .header h1 span { color: var(--gold); }
  .header-sub { font-size: 13px; color: var(--muted); margin-top: 10px; }

  /* ── Cards ── */
  .card {
    background: rgba(255,255,255,0.04);
    border: 1px solid rgba(255,255,255,0.08);
    border-radius: 16px;
    padding: 24px;
    margin-bottom: 20px;
  }
  .card-title {
    font-family: 'DM Mono', monospace;
    font-size: 10px;
    letter-spacing: 0.18em;
    text-transform: uppercase;
    color: var(--gold);
    margin-bottom: 16px;
  }

  /* ── Tabs ── */
  .tabs {
    display: flex;
    gap: 4px;
    margin-bottom: 20px;
    background: rgba(255,255,255,0.04);
    border-radius: 10px;
    padding: 4px;
  }
  .tab {
    flex: 1;
    padding: 8px 12px;
    border-radius: 7px;
    font-size: 13px;
    font-weight: 600;
    cursor: pointer;
    text-align: center;
    transition: all 0.15s;
    color: var(--muted);
    border: none;
    background: transparent;
  }
  .tab.active { background: var(--gold); color: var(--green); }

  /* ── Sections ── */
  .section { display: none; }
  .section.active { display: block; }

  /* ── Group select ── */
  .group-select {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(100px, 1fr));
    gap: 8px;
    margin-bottom: 8px;
  }
  .group-btn {
    background: var(--gold-dim);
    border: 1px solid var(--gold-border);
    color: var(--white);
    padding: 10px 8px;
    border-radius: 10px;
    font-family: 'DM Sans', sans-serif;
    font-size: 13px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.15s;
    text-align: center;
  }
  .group-btn:hover { background: rgba(242,180,0,0.28); border-color: var(--gold); }
  .group-btn.selected { background: var(--gold); color: var(--green); border-color: var(--gold); }
  .group-btn.played { opacity: 0.45; cursor: not-allowed; border-style: dashed; }

  /* ── Buttons ── */
  .btn {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
    padding: 12px 24px;
    border-radius: 10px;
    font-family: 'DM Sans', sans-serif;
    font-size: 14px;
    font-weight: 700;
    cursor: pointer;
    border: none;
    transition: all 0.15s;
    letter-spacing: 0.02em;
  }
  .btn-primary { background: var(--gold); color: var(--green); }
  .btn-primary:hover { background: #ffc820; transform: translateY(-1px); box-shadow: 0 4px 16px rgba(242,180,0,0.3); }
  .btn-primary:disabled { opacity: 0.4; cursor: not-allowed; transform: none; box-shadow: none; }
  .btn-outline { background: transparent; color: var(--gold); border: 1px solid var(--gold-border); }
  .btn-outline:hover { background: var(--gold-dim); }
  .btn-danger { background: transparent; color: var(--danger); border: 1px solid rgba(224,82,82,0.3); font-size: 12px; padding: 8px 14px; }
  .btn-danger:hover { background: rgba(224,82,82,0.1); }
  .full-width { width: 100%; }

  /* ── Wordle grid ── */
  .wordle-grid {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 6px;
    margin: 20px 0;
  }
  .wordle-row {
    display: flex;
    gap: 6px;
  }
  .wordle-tile {
    width: 56px;
    height: 56px;
    border: 2px solid rgba(255,255,255,0.15);
    border-radius: 8px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-family: 'Bebas Neue', sans-serif;
    font-size: 28px;
    color: var(--white);
    background: transparent;
    transition: border-color 0.1s;
    position: relative;
    overflow: hidden;
  }
  .wordle-tile.filled { border-color: rgba(255,255,255,0.4); }
  .wordle-tile.active-row { border-color: var(--gold); }

  /* flip animation */
  .wordle-tile.flip {
    animation: flip 0.5s ease forwards;
  }
  @keyframes flip {
    0%   { transform: rotateX(0deg); }
    50%  { transform: rotateX(-90deg); background: transparent; }
    51%  { transform: rotateX(-90deg); }
    100% { transform: rotateX(0deg); }
  }
  .wordle-tile.correct  { background: var(--correct);  border-color: var(--correct); }
  .wordle-tile.present  { background: var(--present);  border-color: var(--present); }
  .wordle-tile.absent   { background: var(--absent);   border-color: transparent; }

  /* pop animation on type */
  .wordle-tile.pop {
    animation: pop 0.1s ease;
  }
  @keyframes pop {
    0%   { transform: scale(1); }
    50%  { transform: scale(1.12); }
    100% { transform: scale(1); }
  }

  /* shake on bad guess */
  .wordle-row.shake {
    animation: shake 0.4s ease;
  }
  @keyframes shake {
    0%,100% { transform: translateX(0); }
    20%     { transform: translateX(-6px); }
    40%     { transform: translateX(6px); }
    60%     { transform: translateX(-4px); }
    80%     { transform: translateX(4px); }
  }

  /* ── Keyboard ── */
  .keyboard {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 6px;
    margin-top: 16px;
  }
  .kb-row {
    display: flex;
    gap: 5px;
  }
  .kb-key {
    height: 48px;
    min-width: 36px;
    padding: 0 8px;
    border-radius: 6px;
    background: rgba(255,255,255,0.12);
    border: none;
    color: var(--white);
    font-family: 'DM Sans', sans-serif;
    font-size: 13px;
    font-weight: 700;
    cursor: pointer;
    transition: all 0.15s;
    display: flex;
    align-items: center;
    justify-content: center;
  }
  .kb-key:hover { background: rgba(255,255,255,0.2); }
  .kb-key.wide { min-width: 56px; font-size: 11px; }
  .kb-key.correct { background: var(--correct); color: var(--green); }
  .kb-key.present { background: var(--present); color: var(--green); }
  .kb-key.absent  { background: rgba(255,255,255,0.05); color: var(--muted); }

  /* ── Toast ── */
  .toast {
    position: fixed;
    top: 24px;
    left: 50%;
    transform: translateX(-50%) translateY(-80px);
    background: var(--white);
    color: var(--green);
    padding: 10px 20px;
    border-radius: 8px;
    font-weight: 700;
    font-size: 14px;
    z-index: 100;
    transition: transform 0.3s ease;
    pointer-events: none;
  }
  .toast.show { transform: translateX(-50%) translateY(0); }

  /* ── Status pill ── */
  .status-pill {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    padding: 4px 10px;
    border-radius: 20px;
    font-size: 11px;
    font-weight: 600;
  }
  .pill-live { background: rgba(76,175,122,0.15); color: #4caf7a; border: 1px solid rgba(76,175,122,0.3); }
  .pill-dot { width: 6px; height: 6px; border-radius: 50%; background: currentColor; animation: pulse 1.5s infinite; }
  @keyframes pulse { 0%,100%{opacity:1} 50%{opacity:0.3} }

  /* ── Week chip ── */
  .week-info { display: flex; align-items: center; gap: 8px; flex-wrap: wrap; }
  .week-chip {
    background: var(--gold-dim);
    border: 1px solid var(--gold-border);
    border-radius: 20px;
    padding: 4px 12px;
    font-size: 12px;
    color: var(--gold);
    font-weight: 600;
  }

  /* ── Score reveal ── */
  .score-reveal { text-align: center; padding: 16px 0; }
  .score-big { font-family: 'Bebas Neue', sans-serif; font-size: 72px; color: var(--gold); line-height: 1; margin-bottom: 4px; }
  .score-label { font-size: 13px; color: var(--muted); }
  .result-word { font-family: 'Bebas Neue', sans-serif; font-size: 32px; letter-spacing: 0.1em; margin: 8px 0 4px; }

  /* ── Admin ── */
  .admin-panel { display: none; }
  .admin-panel.open { display: block; }
  .admin-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 12px; margin-bottom: 16px; }
  .admin-field label { display: block; font-size: 11px; color: var(--muted); margin-bottom: 6px; text-transform: uppercase; letter-spacing: 0.1em; }
  .admin-input {
    width: 100%;
    background: rgba(255,255,255,0.06);
    border: 1px solid rgba(255,255,255,0.15);
    border-radius: 8px;
    padding: 10px 12px;
    color: var(--white);
    font-family: 'DM Sans', sans-serif;
    font-size: 14px;
    text-transform: uppercase;
    letter-spacing: 0.1em;
  }
  .admin-input:focus { outline: none; border-color: var(--gold); }

  /* ── Util ── */
  .flex-between { display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 8px; }
  .mt16 { margin-top: 16px; }
  .hint-legend { display: flex; gap: 16px; justify-content: center; flex-wrap: wrap; margin-bottom: 8px; }
  .hint-item { display: flex; align-items: center; gap: 6px; font-size: 11px; color: var(--muted); }
  .hint-swatch { width: 16px; height: 16px; border-radius: 3px; }

  @media (max-width: 480px) {
    .wordle-tile { width: 46px; height: 46px; font-size: 24px; }
    .kb-key { height: 42px; min-width: 30px; font-size: 12px; }
    .kb-key.wide { min-width: 46px; }
    .admin-grid { grid-template-columns: 1fr; }
  }
</style>
</head>
<body>
<div class="toast" id="toast"></div>

<div class="container">

  <!-- Header -->
  <div class="header">
    <div class="header-eyebrow">Corinda State High School</div>
    <h1>WOR<span>DLE</span></h1>
    <div class="header-sub">Guess the word of the week — six tries</div>
  </div>

  <!-- Tabs -->
  <div class="tabs">
    <button class="tab active" onclick="switchTab('game')">Game</button>
  </div>

  <!-- ═══ GAME TAB ═══ -->
  <div id="tab-game" class="section active">

    <!-- Sign in -->
    <div id="screen-signin" class="section active">
      <div class="card">
        <div class="card-title">Step 1 — Select your house</div>
        <div class="group-select" id="houseSelect"></div>
        <div id="step2" style="display:none; margin-top:20px;">
          <div class="card-title">Step 2 — Select your group</div>
          <div class="group-select" id="groupLetterSelect"></div>
        </div>
        <div class="mt16">
          <button class="btn btn-primary full-width" id="startBtn" onclick="startGame()" disabled>Start Game</button>
        </div>
      </div>
      <div class="card">
        <div class="card-title">This week</div>
        <div class="week-info" id="weekInfo"></div>
      </div>
    </div>

    <!-- Playing -->
    <div id="screen-playing" class="section">
      <div class="card">
        <div class="flex-between" style="margin-bottom:16px;">
          <div>
            <div class="card-title" style="margin-bottom:4px;">Now playing</div>
            <div style="font-size:15px;font-weight:700;" id="playingGroup">—</div>
          </div>
          <div class="week-info" id="playingWeekChip"></div>
        </div>

        <!-- Legend -->
        <div class="hint-legend">
          <div class="hint-item"><div class="hint-swatch" style="background:var(--correct);"></div> Correct spot</div>
          <div class="hint-item"><div class="hint-swatch" style="background:var(--present);"></div> Wrong spot</div>
          <div class="hint-item"><div class="hint-swatch" style="background:rgba(255,255,255,0.2);"></div> Not in word</div>
        </div>

        <!-- Grid -->
        <div class="wordle-grid" id="wordleGrid"></div>

        <!-- Keyboard -->
        <div class="keyboard" id="keyboard"></div>

        <div style="margin-top:16px; text-align:center;">
          <div id="guessStatus" style="font-size:13px; color:var(--muted); height:20px;"></div>
        </div>
      </div>
    </div>

    <!-- Result -->
    <div id="screen-result" class="section">
      <div class="card">
        <div class="card-title">Round complete</div>
        <div class="score-reveal">
          <div id="resultEmoji" style="font-size:40px; margin-bottom:8px;">🎉</div>
          <div class="score-big" id="finalScore">0</div>
          <div class="score-label" id="scoreLabel">points earned</div>
          <div style="font-size:15px; font-weight:700; color:var(--gold,#f2b400); margin-top:6px;" id="resultGuessCount"></div>
          <div class="result-word" id="resultWordReveal" style="margin-top:8px;"></div>
        </div>
        <div class="mt16" style="display:flex;flex-direction:column;gap:10px;">
          <button class="btn btn-primary full-width" onclick="submitScore_WL()" id="submitScoreBtn" style="font-size:16px;padding:14px;">
            📤 Submit Score
          </button>
          <div style="display:flex;gap:8px;">
            <button class="btn btn-outline" style="flex:1;" onclick="resetToSignin()">← Back</button>
          </div>
          <div id="submitConfirm" style="display:none;text-align:center;font-size:13px;color:#4caf7a;" role="status" aria-live="polite">✓ Form opened in new tab — fill in your details and submit</div>
        </div>
      </div>
    </div>

  </div><!-- ═══ ADMIN TAB ═══ -->
  

</div><!-- /container -->

<script src="../../assets/site-config.js"></script>
<script>

// ─── WEEKLY ATTEMPT LOCK (localStorage, per-device per-week) ─────────────────
// Home groups get one attempt per game per school week. Staff is always unlimited.
// Note: because these are static HTML files, this lock is enforced in this browser/device.
function weeklyLockLabel() {
  if (typeof cshsWeekLabel === 'function') return cshsWeekLabel();
  const terms = window.CSHS_SITE_CONFIG.terms;
  const parse=s=>{const [y,m,d]=s.split('-').map(Number);return new Date(y,m-1,d);};
  const mondayOf=d=>{const x=new Date(d);const dow=(x.getDay()+6)%7;x.setDate(x.getDate()-dow);x.setHours(0,0,0,0);return x;};
  const today=new Date(); today.setHours(0,0,0,0);
  let chosen={t:1,w:1};
  for(const term of terms){
    const end=parse(term.end); let mon=mondayOf(parse(term.start)); let w=1;
    while(mon<=end){
      if(mon<=today) chosen={t:term.t,w}; else return `Term ${chosen.t} Week ${chosen.w}`;
      mon=new Date(mon); mon.setDate(mon.getDate()+7); w++;
    }
  }
  return `Term ${chosen.t} Week ${chosen.w}`;
}
function normaliseGroupName(group) {
  return String(group || '').trim().replace(/\s+/g, ' ');
}
function isStaffGroup(group) {
  const g = normaliseGroupName(group);
  return g === 'Staff' || g.endsWith(' Staff');
}
function getPlayedKey() {
  return 'wordle:played:' + weeklyLockLabel();
}

(function() {
  // ?reset clears played records for this game and redirects cleanly
  if (location.search.includes('reset')) {
    try {
      Object.keys(localStorage).filter(k => k.startsWith('wordle:played:')).forEach(k => localStorage.removeItem(k));
    } catch(e) {}
    history.replaceState(null, '', location.pathname);
  }
})();

function readPlayedList() {
  try {
    const data = JSON.parse(localStorage.getItem(getPlayedKey()) || '[]');
    return Array.isArray(data) ? data : [];
  } catch(e) { return []; }
}

function writePlayedList(data) {
  try { localStorage.setItem(getPlayedKey(), JSON.stringify([...new Set(data.map(normaliseGroupName))])); } catch(e) {}
}

function isPlayed(group) {
  const g = normaliseGroupName(group);
  if (!g || isStaffGroup(g)) return false;
  return readPlayedList().includes(g);
}

function markPlayedLS(group) {
  const g = normaliseGroupName(group);
  if (!g || isStaffGroup(g)) return;
  const data = readPlayedList();
  if (!data.includes(g)) {
    data.push(g);
    writePlayedList(data);
  }
}

function lockWeeklyAttempt(group) {
  const g = normaliseGroupName(group);
  if (!g) return false;
  if (isStaffGroup(g)) return true;
  if (isPlayed(g)) {
    alert(g + ' has already played this game on this browser for ' + weeklyLockLabel() + '. Please choose Staff for practice or wait until next week.');
    return false;
  }
  markPlayedLS(g);
  try { if (typeof played !== 'undefined' && played && played.add) played.add(g); } catch(e) {}
  return true;
}
// ─────────────────────────────────────────────────────────────────────────────

// ─── CONSTANTS ────────────────────────────────────────────────────────────────
const SK_CONFIG  = 'wordle-config';
const SK_SCORES  = 'wordle-scores';
const SK_PLAYED  = 'wordle-played';
const POLL_MS    = 8000;

const HOUSES       = ['Moori','Bunar','Dibbil','Kabul','Pirri','Yarraman'];
const GROUP_LETTERS = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N'];

const KB_ROWS = [
  ['Q','W','E','R','T','Y','U','I','O','P'],
  ['A','S','D','F','G','H','J','K','L'],
  ['ENTER','Z','X','C','V','B','N','M','⌫']
];

const SCORE_BY_GUESS = [100, 85, 70, 55, 40, 25, 10]; // index = guess number (0-based)

const DEFAULT_CONFIG = {
  week: 'Week 1',
  word: 'HAPPY',
  maxGuesses: 6,
  hint: '',
  paUrl: '',
  formUrl: 'https://forms.cloud.microsoft/r/x94vT9B782'
};

// ─── STATE ────────────────────────────────────────────────────────────────────
let config      = { ...DEFAULT_CONFIG };
let scores      = {};
let played      = new Set();
let pollTimer   = null;

let selectedHouse  = null;
let selectedLetter = null;
let selectedGroup  = null;

// game state
let currentGuess = '';
let currentRow   = 0;
let gameStartTime = 0;
let guesses      = []; // array of submitted guess strings
let gameOver     = false;
let isRevealing  = false; // true while a submitted guess is mid-animation, blocks re-entrant submits
let wordLength   = 6;
let maxGuesses   = 6;
let targetWord   = 'HAPPY';
let keyStates    = {}; // letter -> 'correct'|'present'|'absent'

// ─── STORAGE ──────────────────────────────────────────────────────────────────
/* ── AUTO WEEK (shared across all CSHS games) ──────────────────────────────
   Returns the current configured CSHS school week as {term, week, absWeek 1..40}.
   absWeek lets games index a content bank continuously across the year.
   Rule: latest term-week whose Monday is on/before today; holidays hold the
   most recent week; before the year starts, week 1. Matches Wheel of Fortune. */
const CSHS_TERMS = window.CSHS_SITE_CONFIG.terms;
function cshsWeekSchedule(){
  const parse=s=>{const[y,m,d]=s.split('-').map(Number);return new Date(y,m-1,d);};
  const mondayOf=d=>{const x=new Date(d);const dow=(x.getDay()+6)%7;x.setDate(x.getDate()-dow);x.setHours(0,0,0,0);return x;};
  const out=[]; let abs=0;
  for(const term of CSHS_TERMS){
    const end=parse(term.end); let mon=mondayOf(parse(term.start)); let w=1;
    while(mon<=end){ abs++; out.push({t:term.t,w,abs,mon:new Date(mon)}); mon=new Date(mon); mon.setDate(mon.getDate()+7); w++; }
  }
  return out;
}
function cshsCurrentWeek(){
  const sched=cshsWeekSchedule();
  const today=new Date(); today.setHours(0,0,0,0);
  let chosen=sched[0];
  for(const wk of sched){ if(wk.mon<=today) chosen=wk; else break; }
  return chosen; // {t,w,abs,mon}
}

function cshsWeekLabel(){ const w=cshsCurrentWeek(); return `Term ${w.t} · Week ${w.w}`; }

// 40-week word schedule (date-driven, same word for everyone, holds last week in holidays).
// To change a week's answer, edit its `word` (must be letters only; 6 letters recommended).
const WEEKLY_WORDS = [
  { t:1, w:1,  word:"FRESH" },  // Welcome back — fresh start
  { t:1, w:2,  word:"LEARN" },  // Positive Education intro
  { t:1, w:3,  word:"BLOOM" },  // PERMAH overview — flourishing
  { t:1, w:4,  word:"MERIT" },  // Virtues & strengths overview
  { t:1, w:5,  word:"SHARE" },  // Virtue of Humanity
  { t:1, w:6,  word:"HEART" },  // Love
  { t:1, w:7,  word:"SAVVY" },  // Social Intelligence — read the room
  { t:1, w:8,  word:"GRACE" },  // Kindness
  { t:1, w:9,  word:"REACH" },  // Virtue of Transcendence — aim high
  { t:1, w:10, word:"LAUGH" },  // Humour — familiar and accessible across year levels
  { t:2, w:1,  word:"FAITH" },  // Spirituality / Meaning
  { t:2, w:2,  word:"GLEAM" },  // Appreciation of Beauty
  { t:2, w:3,  word:"LIGHT" },  // Hope — light at end of tunnel
  { t:2, w:4,  word:"THANK" },  // Gratitude
  { t:2, w:5,  word:"LOGIC" },  // Virtue of Wisdom
  { t:2, w:6,  word:"STUDY" },  // Love of Learning
  { t:2, w:7,  word:"VISTA" },  // Perspective — big picture
  { t:2, w:8,  word:"QUERY" },  // Curiosity — question everything
  { t:2, w:9,  word:"SPARK" },  // Creativity — creative spark
  { t:2, w:10, word:"WEIGH" },  // Judgement — weigh it up
  { t:3, w:1,  word:"PRIDE" },  // Virtues recap
  { t:3, w:2,  word:"WORTH" },  // PERMAH recap — self-worth
  { t:3, w:3,  word:"EQUAL" },  // Virtue of Justice
  { t:3, w:4,  word:"GUIDE" },  // Leadership — lead the way
  { t:3, w:5,  word:"LEVEL" },  // Fairness — level playing field
  { t:3, w:6,  word:"UNITE" },  // Teamwork — bring people together
  { t:3, w:7,  word:"STEEL" },  // Virtue of Courage — steel yourself
  { t:3, w:8,  word:"GUSTO" },  // Zest — do it with gusto
  { t:3, w:9,  word:"BRAVE" },  // Bravery
  { t:3, w:10, word:"GRIND" },  // Perseverance — keep grinding
  { t:4, w:1,  word:"TRUTH" },  // Honesty
  { t:4, w:2,  word:"NERVE" },  // Courage review — hold your nerve
  { t:4, w:3,  word:"PAUSE" },  // Virtue of Temperance — pause before acting
  { t:4, w:4,  word:"THINK" },  // Prudence — pause and think ahead
  { t:4, w:5,  word:"HUMBLE" }, // Humility
  { t:4, w:6,  word:"FOCUS" },  // Self-Regulation — direct attention deliberately
  { t:4, w:7,  word:"PEACE" },  // Forgiveness
  { t:4, w:8,  word:"GROWN" },  // Year in review — how we've grown
  { t:4, w:9,  word:"FUTURE" }, // Looking ahead
  { t:4, w:10, word:"CHEER" },  // Celebrate and reset
];
function resolveWeekWord(){
  const abs = cshsCurrentWeek().abs;
  const e = WEEKLY_WORDS[(abs - 1) % WEEKLY_WORDS.length];
  return e.word.toUpperCase().replace(/[^A-Z]/g,'');
}

async function loadConfig() {
  try {
    const r = await window.storage.get(SK_CONFIG, true);
    if (r && r.value) config = JSON.parse(r.value);
  } catch(e) {}
}
async function saveConfigStorage() {
  try { await window.storage.set(SK_CONFIG, JSON.stringify(config), true); } catch(e) {}
}
async function loadScores() {
  try {
    const r = await window.storage.get(SK_SCORES + '-' + config.week, true);
    scores = r && r.value ? JSON.parse(r.value) : {};
  } catch(e) { scores = {}; }
}
async function saveScore(group, pts) {
  await loadScores();
  if (scores[group] === undefined || pts > scores[group]) scores[group] = pts;
  try { await window.storage.set(SK_SCORES + '-' + config.week, JSON.stringify(scores), true); } catch(e) {}
}
async function loadPlayed() {
  try {
    const r = await window.storage.get(SK_PLAYED + '-' + config.week, true);
    played = r && r.value ? new Set(JSON.parse(r.value)) : new Set();
  } catch(e) { played = new Set(); }
}
async function markPlayed(group) {
  await loadPlayed();
  played.add(group);
  try { await window.storage.set(SK_PLAYED + '-' + config.week, JSON.stringify([...played]), true); } catch(e) {}
}

// ─── INIT ─────────────────────────────────────────────────────────────────────
async function init() {
  await loadConfig();
  config.word = resolveWeekWord();
  config.week = cshsWeekLabel();
  await loadPlayed();
  renderSignIn();
  renderWeekPreview();
  startPolling();
  document.addEventListener('keydown', handleKeyDown);
}

function startPolling() {
  if (pollTimer) clearInterval(pollTimer);
  pollTimer = setInterval(async () => {
    await loadConfig();
    await loadPlayed();
    renderWeekPreview();
    if (!gameOver) renderSignIn(); // refresh played state on sign-in
  }, POLL_MS);
}

// ─── SIGN IN ──────────────────────────────────────────────────────────────────
function renderSignIn() {
  const houseEl = document.getElementById('houseSelect');
  houseEl.innerHTML = HOUSES.map(h =>
    `<button class="group-btn ${selectedHouse===h?'selected':''}" onclick="selectHouse('${h}')">${h}</button>`
  ).join('');

  const step2 = document.getElementById('step2');
  if (selectedHouse) {
    step2.style.display = 'block';
    const letEl = document.getElementById('groupLetterSelect');
    letEl.innerHTML = GROUP_LETTERS.map(l => {
      const grp  = selectedHouse + ' ' + l;
      const done = played.has(grp);
      const sel  = selectedLetter === l;
      return `<button class="group-btn ${sel?'selected':''} ${done?'played':''}"
        onclick="selectLetter('${l}')" ${done?'title="Already played this week"':''}>
        ${l}${done?' ✓':''}
      </button>`;
    }).join('') + `<button class="group-btn ${selectedLetter==='Staff'?'selected':''}" onclick="selectLetter('Staff')">Staff</button>`;
  } else {
    step2.style.display = 'none';
  }
}

function selectHouse(h) {
  selectedHouse  = h;
  selectedLetter = null;
  selectedGroup  = null;
  document.getElementById('startBtn').disabled = true;
  renderSignIn();
}

function selectLetter(l) {
  selectedLetter = l;
  selectedGroup = (l === 'Staff') ? 'Staff' : selectedHouse + ' ' + l;
  renderSignIn();
  document.getElementById('startBtn').disabled = isPlayed(selectedGroup);
}

function renderWeekPreview() {
  document.getElementById('weekInfo').innerHTML = `
    <div class="week-chip">${cshsWeekLabel()}</div>
    <div class="week-chip">${config.word.length}-letter word</div>
    <div class="week-chip">${config.maxGuesses} guesses</div>
    ${config.hint ? `<div class="week-chip">Hint: ${config.hint}</div>` : ''}
  `;
}

// ─── GAME START ───────────────────────────────────────────────────────────────
function startGame() {
  if (!selectedGroup || !lockWeeklyAttempt(selectedGroup)) return;

  // Sync game params from config
  targetWord  = config.word.toUpperCase().replace(/[^A-Z]/g,'');
  gameStartTime = Date.now();
  wordLength  = targetWord.length;
  maxGuesses  = config.maxGuesses || 6;
  currentGuess = '';
  currentRow   = 0;
  guesses      = [];
  gameOver     = false;
  isRevealing  = false;
  keyStates    = {};

  document.getElementById('playingGroup').textContent = selectedGroup;
  document.getElementById('playingWeekChip').innerHTML =
    `<div class="week-chip">${cshsWeekLabel()}</div>` +
    (config.hint ? `<div class="week-chip">Hint: ${config.hint}</div>` : '');

  buildGrid();
  buildKeyboard();
  document.getElementById('guessStatus').textContent = '';
  showScreen('screen-playing');
}

// ─── GRID ─────────────────────────────────────────────────────────────────────
function buildGrid() {
  const grid = document.getElementById('wordleGrid');
  grid.innerHTML = '';
  for (let r = 0; r < maxGuesses; r++) {
    const row = document.createElement('div');
    row.className = 'wordle-row';
    row.id = `row-${r}`;
    for (let c = 0; c < wordLength; c++) {
      const tile = document.createElement('div');
      tile.className = 'wordle-tile';
      tile.id = `tile-${r}-${c}`;
      row.appendChild(tile);
    }
    grid.appendChild(row);
  }
  highlightActiveRow();
}

function highlightActiveRow() {
  for (let r = 0; r < maxGuesses; r++) {
    const rowEl = document.getElementById(`row-${r}`);
    if (!rowEl) continue;
    [...rowEl.children].forEach(t => {
      t.classList.toggle('active-row', r === currentRow && !t.classList.contains('correct') && !t.classList.contains('present') && !t.classList.contains('absent'));
    });
  }
}

// ─── KEYBOARD ─────────────────────────────────────────────────────────────────
function buildKeyboard() {
  const kb = document.getElementById('keyboard');
  kb.innerHTML = KB_ROWS.map(row => `
    <div class="kb-row">
      ${row.map(k => `
        <button class="kb-key ${k.length>1?'wide':''}" id="kb-${k}" onclick="handleKey('${k}')">${k}</button>
      `).join('')}
    </div>
  `).join('');
}

function updateKeyboard() {
  Object.entries(keyStates).forEach(([letter, state]) => {
    const el = document.getElementById(`kb-${letter}`);
    if (el) {
      el.classList.remove('correct','present','absent');
      el.classList.add(state);
    }
  });
}

// ─── INPUT ────────────────────────────────────────────────────────────────────
function handleKeyDown(e) {
  if (document.getElementById('screen-playing').classList.contains('active') && !gameOver) {
    if (e.key === 'Enter') handleKey('ENTER');
    else if (e.key === 'Backspace') handleKey('⌫');
    else if (/^[a-zA-Z]$/.test(e.key)) handleKey(e.key.toUpperCase());
  }
}

function handleKey(key) {
  if (gameOver) return;

  if (key === '⌫') {
    if (currentGuess.length > 0) {
      currentGuess = currentGuess.slice(0, -1);
      updateCurrentRowDisplay();
    }
    return;
  }

  if (key === 'ENTER') {
    submitGuess();
    return;
  }

  if (currentGuess.length < wordLength) {
    currentGuess += key;
    updateCurrentRowDisplay();
    // pop animation on last typed tile
    const tile = document.getElementById(`tile-${currentRow}-${currentGuess.length-1}`);
    if (tile) { tile.classList.remove('pop'); void tile.offsetWidth; tile.classList.add('pop'); }
  }
}

function updateCurrentRowDisplay() {
  for (let c = 0; c < wordLength; c++) {
    const tile = document.getElementById(`tile-${currentRow}-${c}`);
    if (!tile) continue;
    tile.textContent = currentGuess[c] || '';
    tile.classList.toggle('filled', !!currentGuess[c]);
    tile.classList.toggle('active-row', !currentGuess[c]);
  }
}

// ─── GUESS SUBMISSION ─────────────────────────────────────────────────────────
function submitGuess() {
  if (isRevealing) return; // a previous guess is still animating — ignore double-taps

  if (currentGuess.length < wordLength) {
    shakeRow(currentRow);
    showToast(`Word must be ${wordLength} letters`);
    return;
  }

  const guess = currentGuess.toUpperCase();

  if (!isValidWord(guess)) {
    shakeRow(currentRow);
    showToast('Not a valid word');
    return;
  }
  const result = evaluateGuess(guess, targetWord);

  isRevealing = true;
  guesses.push(guess);
  revealRow(currentRow, guess, result, () => {
    isRevealing = false;
    updateKeyboard();

    const won = result.every(r => r === 'correct');
    if (won) {
      gameOver = true;
      const basePts = SCORE_BY_GUESS[Math.min(currentRow, SCORE_BY_GUESS.length-1)];
      const elapsedSecs = (Date.now() - gameStartTime) / 1000;
      const maxTimeSecs = 180;
      const timeBonus = Math.max(0, Math.round(50 * (1 - elapsedSecs / maxTimeSecs)));
      const pts = basePts + timeBonus;
      showToast('Brilliant! 🎉');
      setTimeout(() => endGame(true, pts), 600);
    } else if (currentRow + 1 >= maxGuesses) {
      gameOver = true;
      showToast(`The word was ${targetWord}`);
      setTimeout(() => endGame(false, 0), 600);
    } else {
      currentRow++;
      currentGuess = '';
      highlightActiveRow();
    }
  });
}

function evaluateGuess(guess, target) {
  // standard Wordle evaluation
  const result = Array(target.length).fill('absent');
  const targetArr = target.split('');
  const guessArr  = guess.split('');
  const used = Array(target.length).fill(false);

  // pass 1: correct
  guessArr.forEach((l, i) => {
    if (l === targetArr[i]) { result[i] = 'correct'; used[i] = true; }
  });
  // pass 2: present
  guessArr.forEach((l, i) => {
    if (result[i] === 'correct') return;
    const j = targetArr.findIndex((t, ti) => t === l && !used[ti]);
    if (j !== -1) { result[i] = 'present'; used[j] = true; }
  });

  // update key states (correct > present > absent)
  guessArr.forEach((l, i) => {
    const cur = keyStates[l];
    const next = result[i];
    if (cur === 'correct') return;
    if (cur === 'present' && next !== 'correct') return;
    keyStates[l] = next;
  });

  return result;
}

function revealRow(row, guess, result, callback) {
  const delay = 300; // ms per tile
  for (let c = 0; c < wordLength; c++) {
    const tile = document.getElementById(`tile-${row}-${c}`);
    if (!tile) continue;
    const state = result[c];
    setTimeout(() => {
      tile.classList.add('flip');
      setTimeout(() => {
        tile.classList.remove('active-row','filled');
        tile.classList.add(state);
      }, delay / 2);
    }, c * delay);
  }
  setTimeout(callback, wordLength * delay + 100);
}

function shakeRow(row) {
  const rowEl = document.getElementById(`row-${row}`);
  if (!rowEl) return;
  rowEl.classList.remove('shake');
  void rowEl.offsetWidth;
  rowEl.classList.add('shake');
  setTimeout(() => rowEl.classList.remove('shake'), 400);
}

// ─── END GAME ─────────────────────────────────────────────────────────────────
// Solved: 1-2 -> 10, 3 -> 9, 4 -> 8, 5 -> 7, 6 -> 6.
// Not solved but had a go (>=1 guess) -> 3. No guesses at all -> 0.
function scoreByGuesses(won, numGuesses){
  if (won){
    if (numGuesses <= 2) return 10;
    if (numGuesses === 3) return 9;
    if (numGuesses === 4) return 8;
    if (numGuesses === 5) return 7;
    return 6; // 6 guesses
  }
  return numGuesses >= 1 ? 3 : 0;   // participation floor for a genuine attempt
}
async function endGame(won, pts) {
  const n = guesses.length;
  const scaled = scoreByGuesses(won, n);
  await saveScore(selectedGroup, scaled);
  await markPlayed(selectedGroup);
  window._lastResult = { group: selectedGroup, score: scaled,
    house: selectedGroup.split(' ')[0],
    detail: won ? 'Solved in ' + n + ' guess' + (n===1?'':'es')
                : (n >= 1 ? 'Not solved (' + n + ' guess' + (n===1?'':'es') + ')' : 'No guesses') };

  document.getElementById('finalScore').textContent = scaled;
  document.getElementById('resultEmoji').textContent = won ? '🎉' : '🙂';

  // How the score was worked out
  let breakdown;
  if (won){
    breakdown = n <= 2
      ? `Solved in ${n} guess${n===1?'':'es'} → top score!`
      : `Solved in ${n} guesses → ${scaled} out of 10`;
  } else if (n >= 1){
    breakdown = `${n} guess${n===1?'':'es'} made → 3 out of 10 for having a go`;
  } else {
    breakdown = `No guesses made → 0 out of 10`;
  }

  document.getElementById('scoreLabel').textContent = won
    ? `out of 10`
    : `out of 10`;
  document.getElementById('resultGuessCount').textContent = breakdown;
  document.getElementById('resultWordReveal').textContent = won
    ? ''
    : `Better luck next time. Thanks for having a go!  The word was: ${targetWord}`;

  showScreen('screen-result');
}

// ─── SCREENS ──────────────────────────────────────────────────────────────────
function showScreen(id) {
  ['screen-signin','screen-playing','screen-result'].forEach(s =>
    document.getElementById(s).classList.toggle('active', s === id)
  );
}

function resetToSignin() {
  selectedGroup  = null;
  selectedHouse  = null;
  selectedLetter = null;
  gameOver       = false;
  renderSignIn();
  document.getElementById('startBtn').disabled = true;
  showScreen('screen-signin');
}

// ─── TOAST ────────────────────────────────────────────────────────────────────
let toastTimer = null;
function showToast(msg) {
  const t = document.getElementById('toast');
  t.textContent = msg;
  t.classList.add('show');
  if (toastTimer) clearTimeout(toastTimer);
  toastTimer = setTimeout(() => t.classList.remove('show'), 2000);
}

// ─── TABS ─────────────────────────────────────────────────────────────────────
function switchTab(name) {
  ['game','admin'].forEach(t => {
    document.getElementById(`tab-${t}`).classList.toggle('active', t === name);
  });
  document.querySelectorAll('.tab').forEach((btn, i) =>
    btn.classList.toggle('active', ['game','admin'][i] === name)
  );
}

// ─── ADMIN ────────────────────────────────────────────────────────────────────


async function saveConfig() {
  config.word       = resolveWeekWord();
  config.week       = cshsWeekLabel();

  await saveConfigStorage();
  renderWeekPreview();

  saved.style.display = 'block';
  setTimeout(() => saved.style.display = 'none', 2500);
}

async function resetLeaderboard() {
  if (!confirm(`Reset all scores and played locks for ${config.week}?`)) return;
  scores = {};
  played = new Set();
  try { await window.storage.set(SK_SCORES + '-' + config.week, JSON.stringify({}), true); } catch(e) {}
  try { await window.storage.set(SK_PLAYED + '-' + config.week, JSON.stringify([]), true); } catch(e) {}
  renderSignIn();
}


// ─── COPY SCORES ──────────────────────────────────────────────────────────────
async function copyScores() {
  await loadScores();
  const sorted = Object.entries(scores).sort((a,b) => b[1]-a[1]);
  if (sorted.length === 0) { alert('No scores to copy yet.'); return; }

  const guessLabel = (pts) => {
    if (pts === 0) return 'Not solved';
    const idx = SCORE_BY_GUESS.indexOf(pts);
    return idx !== -1 ? `Solved in ${idx+1}` : `${pts} pts`;
  };

  const header = `Wordle — ${config.week}\tWord length: ${config.word.length}\t${new Date().toLocaleDateString('en-AU')}`;
  const cols   = 'Rank\tGroup\tScore\tResult';
  const rows   = sorted.map(([name, score], i) =>
    `${i+1}\t${name}\t${score}\t${guessLabel(score)}`
  ).join('\n');
  const text = `${header}\n${cols}\n${rows}`;

  try {
    await navigator.clipboard.writeText(text);
  } catch(e) {
    const ta = document.createElement('textarea');
    ta.value = text; ta.style.position = 'fixed'; ta.style.opacity = '0';
    document.body.appendChild(ta); ta.select();
    document.execCommand('copy'); document.body.removeChild(ta);
  }
  const el = document.getElementById('copyConfirm');
  el.style.display = 'block';
  setTimeout(() => el.style.display = 'none', 3000);
}



// ─── MICROSOFT FORMS SUBMIT ───────────────────────────────────────────────────
function openFormSubmit(group, house, score, week, game, detail) {
  const params = new URLSearchParams({
    id: 'xccAZrUWr0uekzI72MAduqpmcw_jVYVCjN05AfEP1IdUOUtFVUJQOFhZWjRZNjAzRkMyWlozTUpTUy4u',
    rb28fecc633264af694f45d8cf2b3b8c1: week,
    rdbbd457b83da425e93f978536b950482: game,
    rd04d4cf9da8a4213820791f91cdcf6ba: house,
    r3022db1950b649218496e706728c203f: group,
    r8b61653d0854482a9e7e329026083f7b: String(score)
  });
  window.open('https://forms.cloud.microsoft/Pages/ResponsePage.aspx?' + params.toString(), '_blank');
}


function submitScore_WL() {
  const r = window._lastResult || {};
  openFormSubmit(r.group||'', r.house||'', r.score||0, config.week, 'Wordle', r.detail||'');
  document.getElementById('submitConfirm').style.display = 'block';
  document.getElementById('submitScoreBtn').textContent = '↗ Reopen form';
  document.getElementById('submitScoreBtn').disabled = false;
}

// ─── WORD LIST ───────────────────────────────────────────────────────────────
const WORD_LIST = {
  4: new Set(['AGED']),
  5: new Set(['ABOUT', 'ABOVE', 'ABUSE', 'ACUTE', 'ADMIT', 'ADOPT', 'ADULT', 'AFTER', 'AGAIN', 'AGENT', 'AGILE', 'AGREE', 'AHEAD', 'AIMED', 'ALERT', 'ALIGN', 'ALIKE', 'ALIVE', 'ALOFT', 'ALONE', 'ALONG', 'ALOOF', 'ALTER', 'ANGEL', 'ANGER', 'ANGLE', 'ANGRY', 'ANKLE', 'ANNOY', 'APART', 'APPLE', 'APPLY', 'AROSE', 'ARRAY', 'ASIDE', 'ASKED', 'ASSET', 'ATLAS', 'ATONE', 'ATTIC', 'AUDIO', 'AUDIT', 'AVAIL', 'AVOID', 'AWAKE', 'AWARD', 'AWARE', 'AWFUL', 'AXIOM', 'BADLY', 'BAKER', 'BASIC', 'BASIS', 'BATCH', 'BEACH', 'BEARD', 'BEAST', 'BEGAN', 'BEGIN', 'BEING', 'BELOW', 'BENCH', 'BIBLE', 'BIOME', 'BIRTH', 'BISON', 'BLADE', 'BLAME', 'BLAND', 'BLANK', 'BLAZE', 'BLEAK', 'BLEED', 'BLEND', 'BLESS', 'BLIND', 'BLISS', 'BLOCK', 'BLOOD', 'BLOOM', 'BLOWN', 'BLUNT', 'BLUSH', 'BOARD', 'BOAST', 'BONUS', 'BOOBY', 'BOOST', 'BOOTH', 'BORED', 'BRACE', 'BRAID', 'BRAIN', 'BRAVE', 'BREAD', 'BREAK', 'BREED', 'BRICK', 'BRIEF', 'BRING', 'BROAD', 'BROKE', 'BROOK', 'BROTH', 'BROWN', 'BRUSH', 'BUILD', 'BUILT', 'BURST', 'BUYER', 'CABIN', 'CAMEL', 'CANDY', 'CARGO', 'CARRY', 'CATCH', 'CAUSE', 'CEASE', 'CHAIN', 'CHAIR', 'CHALK', 'CHAOS', 'CHARM', 'CHART', 'CHASE', 'CHEAP', 'CHEAT', 'CHECK', 'CHEEK', 'CHEER', 'CHESS', 'CHEST', 'CHIEF', 'CHILD', 'CHILL', 'CHIPS', 'CHOIR', 'CHOSE', 'CIVIC', 'CIVIL', 'CLAIM', 'CLANG', 'CLASH', 'CLASP', 'CLASS', 'CLEAN', 'CLEAR', 'CLERK', 'CLICK', 'CLIFF', 'CLIMB', 'CLING', 'CLOCK', 'CLONE', 'CLOSE', 'CLOTH', 'CLOUD', 'CLOUT', 'CLOWN', 'COACH', 'COAST', 'COBRA', 'COMET', 'COMIC', 'COMMA', 'CORAL', 'COULD', 'COUNT', 'COURT', 'COVER', 'CRACK', 'CRAFT', 'CRASH', 'CRAVE', 'CRAZY', 'CREAM', 'CREDO', 'CREED', 'CREEK', 'CREST', 'CRISP', 'CROOK', 'CROSS', 'CROWD', 'CROWN', 'CRUEL', 'CRUMB', 'CRUSH', 'CURVE', 'CYCLE', 'DAILY', 'DANCE', 'DARED', 'DEALS', 'DEBUT', 'DECAY', 'DEFER', 'DELAY', 'DELTA', 'DENSE', 'DEPOT', 'DEPTH', 'DERBY', 'DIRTY', 'DISCO', 'DIVER', 'DIZZY', 'DODGE', 'DOING', 'DOUBT', 'DOUGH', 'DRAFT', 'DRAIN', 'DRAMA', 'DRANK', 'DRAWN', 'DREAM', 'DRESS', 'DRIED', 'DRILL', 'DRINK', 'DRIVE', 'DRONE', 'DROVE', 'DRUNK', 'DRYER', 'DUNNO', 'DWARF', 'EAGER', 'EAGLE', 'EARLY', 'EARTH', 'EIGHT', 'ELITE', 'EMBER', 'EMOTE', 'EMPTY', 'ENJOY', 'ENTER', 'ENVOY', 'EPOCH', 'EQUAL', 'EQUIP', 'ERROR', 'ESSAY', 'ETHER', 'ETHOS', 'EVADE', 'EVENT', 'EXACT', 'EXERT', 'EXIST', 'EXTRA', 'FABLE', 'FAINT', 'FAIRY', 'FAITH', 'FANCY', 'FATAL', 'FEAST', 'FENCE', 'FERAL', 'FEVER', 'FEWER', 'FIBRE', 'FIFTY', 'FIGHT', 'FILED', 'FINAL', 'FIRST', 'FIXED', 'FLANK', 'FLARE', 'FLASH', 'FLASK', 'FLESH', 'FLOOD', 'FLOOR', 'FLOSS', 'FLOUR', 'FLOWN', 'FLUTE', 'FOCUS', 'FOGGY', 'FOLKS', 'FORCE', 'FORGE', 'FORTE', 'FOUND', 'FRAUD', 'FREAK', 'FREED', 'FRESH', 'FRONT', 'FROST', 'FROZE', 'FRUIT', 'FULLY', 'FUNNY', 'GAUGE', 'GENRE', 'GHOST', 'GIANT', 'GIDDY', 'GIVEN', 'GLAND', 'GLASS', 'GLEAM', 'GLIDE', 'GLOOM', 'GLOSS', 'GLOVE', 'GOING', 'GRACE', 'GRADE', 'GRAFT', 'GRAIN', 'GRAND', 'GRASP', 'GRASS', 'GRATE', 'GRAVE', 'GRAZE', 'GREAT', 'GREED', 'GREET', 'GRIEF', 'GRIND', 'GROAN', 'GROOM', 'GROPE', 'GROSS', 'GROUP', 'GROVE', 'GROWN', 'GRUFF', 'GUARD', 'GUESS', 'GUEST', 'GUIDE', 'GUILD', 'GUILT', 'GUISE', 'GUSTO', 'HAPPY', 'HARSH', 'HAVEN', 'HEARD', 'HEART', 'HEAVY', 'HENCE', 'HERBS', 'HINGE', 'HIPPO', 'HOARY', 'HOLLY', 'HOMER', 'HORSE', 'HOTEL', 'HOUND', 'HOUSE', 'HUMAN', 'HUMID', 'HUMPH', 'HUMUS', 'HURRY', 'HYENA', 'IDEAL', 'IGLOO', 'IMAGE', 'IMPLY', 'INEPT', 'INERT', 'INFER', 'INNER', 'INPUT', 'INTEL', 'INTER', 'IRONY', 'ISSUE', 'IVORY', 'JAUNT', 'JAZZY', 'JEWEL', 'JOUST', 'JUDGE', 'JUICE', 'JUICY', 'JUMBO', 'KARMA', 'KHAKI', 'KNACK', 'KNEEL', 'KNELT', 'KNIFE', 'KNOBS', 'KNOCK', 'KNOWN', 'KUDOS', 'LABEL', 'LANCE', 'LARGE', 'LASER', 'LATCH', 'LATER', 'LATTE', 'LAUGH', 'LAYER', 'LEAKY', 'LEARN', 'LEDGE', 'LEGAL', 'LEMON', 'LEVEL', 'LIGHT', 'LITHE', 'LIVER', 'LOFTY', 'LOGIC', 'LOOSE', 'LUNGE', 'LUSTY', 'LYRIC', 'MAGIC', 'MAJOR', 'MAKER', 'MANOR', 'MAPLE', 'MARCH', 'MARSH', 'MATCH', 'MAXIM', 'MAYOR', 'MEALY', 'MEDIA', 'MERCY', 'MERGE', 'MERIT', 'METAL', 'MIGHT', 'MINOR', 'MIRTH', 'MOIST', 'MONEY', 'MONTH', 'MOODY', 'MOOSE', 'MORAL', 'MOSSY', 'MOURN', 'MOUSE', 'MOUTH', 'MUDDY', 'MUSTY', 'NAIVE', 'NERVE', 'NEVER', 'NEXUS', 'NIGHT', 'NOBLE', 'NOISE', 'NOTED', 'NOVEL', 'NUDGE', 'NURSE', 'NYMPH', 'OCEAN', 'OFFER', 'OFTEN', 'OLIVE', 'ONSET', 'OPERA', 'ORBIT', 'ORDER', 'ORGAN', 'OTHER', 'OUGHT', 'OUTDO', 'OUTER', 'OVARY', 'OWING', 'OXIDE', 'OZONE', 'PAINT', 'PANEL', 'PANIC', 'PAPER', 'PARSE', 'PARTY', 'PASTE', 'PATCH', 'PAUSE', 'PEACE', 'PEACH', 'PEARL', 'PENAL', 'PENNY', 'PERCH', 'PERIL', 'PERKY', 'PETTY', 'PHASE', 'PHOTO', 'PIANO', 'PILOT', 'PIVOT', 'PIXEL', 'PIZZA', 'PLAID', 'PLAIN', 'PLANK', 'PLANT', 'PLATE', 'PLAZA', 'PLEAD', 'PLUCK', 'PLUMB', 'PLUME', 'PLUMP', 'PLUNK', 'POISE', 'POLAR', 'POSED', 'POUCH', 'PRANK', 'PRESS', 'PRICE', 'PRIDE', 'PRIMA', 'PRIME', 'PRISM', 'PRIZE', 'PROBE', 'PRONE', 'PROOF', 'PROSE', 'PROUD', 'PROVE', 'PROWL', 'PROXY', 'PRUNE', 'PULSE', 'PUPIL', 'PUREE', 'PURSE', 'QUACK', 'QUALM', 'QUERY', 'QUEST', 'QUEUE', 'QUICK', 'QUIET', 'QUOTA', 'QUOTE', 'RACER', 'RADAR', 'RAISE', 'RALLY', 'RANCH', 'RANGE', 'RAPID', 'RAVEN', 'REACH', 'REACT', 'READY', 'REALM', 'REBEL', 'REIGN', 'RELAX', 'REMIT', 'REPAY', 'REPEL', 'RERUN', 'REUSE', 'REVEL', 'RIPEN', 'RISEN', 'RISKY', 'RIVET', 'ROAST', 'ROBIN', 'ROCKY', 'ROGUE', 'ROUGE', 'ROUGH', 'ROUND', 'ROWDY', 'RULER', 'RUMOR', 'RUSTY', 'SADLY', 'SAINT', 'SALAD', 'SALTY', 'SALVE', 'SAUCE', 'SAUTE', 'SAVOR', 'SAVVY', 'SCALE', 'SCAMP', 'SCARY', 'SCENE', 'SCONE', 'SCOOP', 'SCOPE', 'SCOUT', 'SCRAP', 'SCREW', 'SERUM', 'SHAFT', 'SHAKY', 'SHAME', 'SHAPE', 'SHARE', 'SHARP', 'SHEER', 'SHELF', 'SHELL', 'SHIFT', 'SHINE', 'SHIRT', 'SHOCK', 'SHORE', 'SHOUT', 'SHOVE', 'SHOWN', 'SHRUG', 'SIEGE', 'SIGHT', 'SILLY', 'SINCE', 'SIREN', 'SIXTH', 'SIXTY', 'SKILL', 'SKIMP', 'SKULL', 'SLATE', 'SLEEK', 'SLEEP', 'SLEET', 'SLEPT', 'SLIDE', 'SLING', 'SLOTH', 'SLUNK', 'SLURP', 'SMART', 'SMASH', 'SMEAR', 'SMELL', 'SMILE', 'SMIRK', 'SMOKE', 'SNACK', 'SNAKE', 'SNARE', 'SNORT', 'SOLAR', 'SOLID', 'SOLVE', 'SORRY', 'SOUTH', 'SPACE', 'SPARE', 'SPARK', 'SPAWN', 'SPEAR', 'SPECK', 'SPELL', 'SPICE', 'SPILL', 'SPINE', 'SPITE', 'SPLAT', 'SPOIL', 'SPOON', 'SPORE', 'SPORT', 'SPOUT', 'SPRAY', 'SPREE', 'SPRIG', 'SPUNK', 'SQUAD', 'SQUAT', 'SQUID', 'STAIN', 'STAIR', 'STAKE', 'STALE', 'STALL', 'STARE', 'START', 'STASH', 'STATE', 'STAVE', 'STEAD', 'STEAL', 'STEAM', 'STEEL', 'STEEP', 'STEER', 'STERN', 'STILL', 'STING', 'STOCK', 'STOIC', 'STONE', 'STOOD', 'STORE', 'STORM', 'STORY', 'STOUT', 'STRAW', 'STRAY', 'STRIP', 'STRUT', 'STUCK', 'STUDY', 'STUNT', 'STYLE', 'SUGAR', 'SUITE', 'SUNNY', 'SUPER', 'SURGE', 'SWAMP', 'SWEAR', 'SWEAT', 'SWEEP', 'SWEET', 'SWEPT', 'SWIFT', 'SWIRL', 'SWOOP', 'SYRUP', 'TABOO', 'TACIT', 'TAUNT', 'TENSE', 'TENTH', 'TEPID', 'TERSE', 'THANK', 'THICK', 'THING', 'THINK', 'THIRD', 'THOSE', 'THREW', 'THUMP', 'TIDAL', 'TIGER', 'TIGHT', 'TIMED', 'TIMID', 'TIRED', 'TITLE', 'TOAST', 'TOTAL', 'TOUCH', 'TOUGH', 'TOWEL', 'TOWER', 'TOXIC', 'TRACE', 'TRACK', 'TRADE', 'TRAIL', 'TRAIN', 'TRAIT', 'TRAMP', 'TRASH', 'TRAWL', 'TREAD', 'TREND', 'TRIAD', 'TRIAL', 'TRIBE', 'TRICK', 'TRIED', 'TROOP', 'TROTH', 'TROUT', 'TRUCE', 'TRULY', 'TRUMP', 'TRUNK', 'TRUST', 'TRUTH', 'TUMOR', 'TWIST', 'TYING', 'ULCER', 'UNCLE', 'UNDER', 'UNIFY', 'UNION', 'UNITE', 'UNITY', 'UNTIL', 'UPPER', 'UPSET', 'URBAN', 'USAGE', 'USHER', 'UTTER', 'VALID', 'VALOR', 'VALVE', 'VAPID', 'VAULT', 'VERSE', 'VIGOR', 'VIRAL', 'VISIT', 'VISOR', 'VISTA', 'VITAL', 'VIVID', 'VOCAL', 'VOGUE', 'VOICE', 'VOILA', 'VOTER', 'VYING', 'WAGER', 'WALTZ', 'WASTE', 'WATCH', 'WATER', 'WEARY', 'WEAVE', 'WEDGE', 'WEIGH', 'WEIRD', 'WELCH', 'WHIFF', 'WHILE', 'WHIRL', 'WHOSE', 'WIDER', 'WIELD', 'WINCE', 'WIRED', 'WITCH', 'WITTY', 'WOMEN', 'WORLD', 'WORRY', 'WORSE', 'WORST', 'WORTH', 'WOUND', 'WRATH', 'WRITE', 'WROTE', 'YEAST', 'YIELD', 'YOUNG', 'YOUTH', 'ZESTY', 'ZONAL']),
  6: new Set(['ABROAD', 'ABSORB', 'ACCEPT', 'ACCESS', 'ACCORD', 'ACCUSE', 'ACTION', 'ACTIVE', 'ACTUAL', 'ADJUST', 'ADMIRE', 'AFFIRM', 'AFFORD', 'AFRAID', 'AGENCY', 'AGENDA', 'ALMOST', 'ALWAYS', 'ANIMAL', 'ANSWER', 'APPEAL', 'AROUND', 'ATTACK', 'ATTEND', 'BEAUTY', 'BECOME', 'BEFORE', 'BEHAVE', 'BELIEF', 'BELONG', 'BESIDE', 'BETTER', 'BEYOND', 'BITTER', 'BOTTLE', 'BRANCH', 'BREATH', 'BRIDGE', 'BROKEN', 'BUDGET', 'BURDEN', 'BUTTON', 'CANDLE', 'CAREER', 'CASTLE', 'CASUAL', 'CAUGHT', 'CENTER', 'CENTRE', 'CHANGE', 'CHOICE', 'CHOOSE', 'CHURCH', 'CIRCLE', 'CLEVER', 'CLOSET', 'COMMIT', 'COMMON', 'COMPLY', 'COUNTY', 'COUPLE', 'COURSE', 'CRAFTY', 'CREATE', 'CUSTOM', 'DAMAGE', 'DANGER', 'DARING', 'DEBATE', 'DECIDE', 'DEEPLY', 'DEFEND', 'DEFINE', 'DEGREE', 'DELETE', 'DESERT', 'DESIGN', 'DETAIL', 'DINNER', 'DIRECT', 'DIVIDE', 'DOCTOR', 'DOMAIN', 'DOUBLE', 'DRAGON', 'DRIVEN', 'EFFECT', 'EFFORT', 'ENABLE', 'ENDING', 'ENERGY', 'ENGAGE', 'ENSURE', 'ENTIRE', 'ESCAPE', 'ETHICS', 'EVENTS', 'EVOLVE', 'EXCEPT', 'EXPAND', 'EXPERT', 'FACTOR', 'FALLOW', 'FAMILY', 'FAMINE', 'FAMOUS', 'FASTER', 'FATHER', 'FELLOW', 'FIGURE', 'FILTER', 'FINGER', 'FINISH', 'FIRMLY', 'FLIGHT', 'FLYING', 'FOLLOW', 'FORGET', 'FORMAL', 'FOSTER', 'FRIEND', 'FROZEN', 'FUTURE', 'GARDEN', 'GATHER', 'GENIUS', 'GENTLE', 'GIFTED', 'GLANCE', 'GLOBAL', 'GRIEVE', 'GROUND', 'GROWTH', 'GUILTY', 'HANDLE', 'HAPPEN', 'HARDLY', 'HEALTH', 'HEAVEN', 'HEREBY', 'HIDDEN', 'HIGHER', 'HONEST', 'HONOUR', 'HUMBLE', 'HUNGER', 'IMPACT', 'INDEED', 'INFORM', 'INSIST', 'INTENT', 'ISLAND', 'JOYFUL', 'JUNGLE', 'JUNIOR', 'KNIGHT', 'LATEST', 'LAUNCH', 'LEADER', 'LESSEN', 'LESSON', 'LETTER', 'LISTEN', 'LITTLE', 'LIVELY', 'LOCATE', 'LOVING', 'LOWEST', 'MANAGE', 'MASTER', 'MATTER', 'MATURE', 'MEMBER', 'MENTAL', 'MIDDLE', 'MIGHTY', 'MIRROR', 'MODERN', 'MOMENT', 'MORALS', 'MOTHER', 'MOTION', 'NATURE', 'NEARBY', 'NEEDED', 'NEWEST', 'NICELY', 'NIMBLY', 'NOTICE', 'NOTION', 'NUMBER', 'OBJECT', 'OBTAIN', 'ONLINE', 'OPTION', 'ORIGIN', 'OTHERS', 'OUTRUN', 'PARENT', 'PERSON', 'PHOBIA', 'PHRASE', 'PLANET', 'PLAYER', 'PLEASE', 'PLUNGE', 'POETIC', 'POLICY', 'POLISH', 'PORTAL', 'PREFER', 'PRETTY', 'PROVEN', 'PURELY', 'PURSUE', 'RACIAL', 'RANDOM', 'RATHER', 'REASON', 'RECENT', 'RECORD', 'REFORM', 'RELATE', 'REMAIN', 'REPAIR', 'REPEAT', 'REPORT', 'RESULT', 'REVEAL', 'REWARD', 'RISING', 'ROBUST', 'RULING', 'SAFELY', 'SAMPLE', 'SAYING', 'SCHOOL', 'SEARCH', 'SECOND', 'SECURE', 'SELECT', 'SENIOR', 'SERIES', 'SIGNAL', 'SIMPLE', 'SINGLE', 'SLOWLY', 'SOCIAL', 'SOLELY', 'SOURCE', 'SPIRIT', 'SPREAD', 'SPRING', 'SQUARE', 'STABLE', 'STREAM', 'STREET', 'STRICT', 'STRONG', 'SUBMIT', 'SUMMER', 'SUPPLY', 'SURELY', 'SWITCH', 'SYMBOL', 'SYSTEM', 'TALENT', 'TARGET', 'TENDER', 'THEORY', 'THIRTY', 'THOUGH', 'TONGUE', 'TRAVEL', 'TRIPLE', 'TRYING', 'UNIQUE', 'UNLESS', 'UNLOCK', 'UPDATE', 'USEFUL', 'VERIFY', 'VICTIM', 'VIRTUE', 'VISION', 'VISUAL', 'VOLUME', 'WISDOM', 'WITHAL', 'WONDER', 'WORTHY', 'YEARLY', 'ZEALOT']),
  7: new Set(['AMAZING', 'BALANCE', 'BELIEVE', 'BETWEEN', 'CALLING', 'CAPABLE', 'CAREFUL', 'CHAPTER', 'CHARITY', 'CLOSEST', 'COMFORT', 'COMPARE', 'COMPETE', 'CONCEPT', 'CONCERN', 'CONDUCT', 'CONTEXT', 'COURAGE', 'CRYSTAL', 'CULTURE', 'DEFENSE', 'DESTINY', 'DEVELOP', 'DIGITAL', 'DISCUSS', 'DISTANT', 'DIVERSE', 'EMBRACE', 'EMOTION', 'EXAMINE', 'EXAMPLE', 'EXPLORE', 'EXPRESS', 'FEELING', 'FICTION', 'FOREVER', 'FORWARD', 'FREEDOM', 'GENERAL', 'GENUINE', 'GREATER', 'HIGHEST', 'HISTORY', 'HOWEVER', 'IMAGINE', 'IMPROVE', 'INCLUDE', 'INSPIRE', 'JUSTICE', 'KINDRED', 'KNOWING', 'LASTING', 'LEADING', 'LOYALTY', 'MEANING', 'MESSAGE', 'MISSION', 'NOTABLE', 'NOTHING', 'OBSERVE', 'OPINION', 'OUTSIDE', 'PASSION', 'PERFECT', 'PERFORM', 'PERSIST', 'POPULAR', 'PRIVATE', 'PRODUCE', 'PROGRAM', 'PROJECT', 'PROMISE', 'PROMOTE', 'PROTECT', 'PURPOSE', 'RADICAL', 'REALITY', 'REFLECT', 'RELEASE', 'REQUIRE', 'RESOLVE', 'RESPECT', 'RESPOND', 'RESTORE', 'RESULTS', 'SCIENCE', 'SERVICE', 'SHARING', 'SHOWING', 'SILENCE', 'SOCIETY', 'SOMEONE', 'SPECIAL', 'STUDENT', 'SUCCESS', 'SUPPORT', 'SUSTAIN', 'TEACHER', 'TOWARDS', 'TROUBLE', 'TYPICAL', 'UNKNOWN', 'VICTORY', 'WILLING', 'WITHOUT', 'WORKING']),
  8: new Set(['BALANCED', 'BRINGING', 'BUILDING', 'CHAMPION', 'CHANGING', 'CHILDREN', 'CHOOSING', 'CLAIMING', 'CLEARING', 'CLIMBING', 'COMPLETE', 'CONSTANT', 'CREATING', 'CREATIVE', 'DELICATE', 'DESCRIBE', 'DETAILED', 'DIRECTLY', 'DISCOVER', 'DISTINCT', 'FAITHFUL', 'GENEROUS', 'GRACIOUS', 'GRATEFUL', 'INVOLVED', 'LEARNING', 'MULTIPLE', 'NATIONAL', 'NEGATIVE', 'PEACEFUL', 'PERSONAL', 'POSITIVE', 'POWERFUL', 'PRACTICE', 'PRECIOUS', 'PRESENCE', 'PROBLEMS', 'PROGRESS', 'RELIABLE', 'RESEARCH', 'REWARDED', 'SELFLESS', 'SEPARATE', 'SHOULDER', 'SOLUTION', 'STANDING', 'STRENGTH', 'STRUGGLE', 'TEACHING', 'THINKING', 'THOUSAND', 'TOGETHER', 'TOMORROW', 'UNIQUELY', 'VALUABLE', 'WHATEVER', 'WHENEVER', 'WHEREVER', 'YEARNING']),
};

function isValidWord(word) {
  const w = word.toUpperCase().trim();
  // Always accept the target word
  if (w === targetWord) return true;
  // If it's in the word list — accept immediately
  const list = WORD_LIST[w.length];
  if (list && list.has(w)) return true;
  // Not in list — run gibberish check
  // Must contain at least one vowel
  if (!/[AEIOU]/.test(w)) return false;
  // Must not have more than 4 consecutive consonants
  if (/[^AEIOU]{5,}/.test(w)) return false;
  // Must not be all the same letter
  if (/^(.)+$/.test(w)) return false;
  // Passes — allow it
  return true;
}

// ─── START ────────────────────────────────────────────────────────────────────
init();
</script>
</body>
</html>
