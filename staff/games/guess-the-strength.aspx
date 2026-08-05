<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Guess the Strength — CSHS Homegroup Games</title>
<style>
  @import url('../../assets/fonts/fonts.css');
  :root {
    --green: #00180f; --green-mid: #003d1f; --green-light: #005a2e;
    --gold: #f2b400; --gold-dim: rgba(242,180,0,0.15); --gold-border: rgba(242,180,0,0.3);
    --white: #fdfdfd; --muted: rgba(255,255,255,0.55); --danger: #e05252; --correct: #4caf7a;
    --w: #2e6b9e; --c: #b94030; --h: #c75e8b; --j: #3a7d44; --t: #7b5ea7; --tr: #c07820;
  }
  * { box-sizing: border-box; margin: 0; padding: 0; }
  body { font-family: 'DM Sans', sans-serif; background: var(--green); color: var(--white); min-height: 100vh; display: flex; flex-direction: column; align-items: center; padding: 24px 16px; }
  .wrap { width: 100%; max-width: 980px; }
  .header { text-align: center; margin-bottom: 18px; }
  .header-eyebrow { font-family: 'DM Mono', monospace; font-size: 10px; letter-spacing: 0.18em; text-transform: uppercase; color: var(--gold); margin-bottom: 6px; }
  .header h1 { font-family: 'Bebas Neue', sans-serif; font-size: clamp(1.8rem, 6vw, 2.6rem); letter-spacing: 0.06em; }
  .header h1 span { color: var(--gold); }
  .panel { background: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.1); border-radius: 14px; padding: 20px; margin-bottom: 16px; }
  .card-title { font-family: 'DM Mono', monospace; font-size: 10px; letter-spacing: 0.18em; text-transform: uppercase; color: var(--gold); margin-bottom: 14px; }
  .screen { display: none; } .screen.active { display: block; }

  /* sign-in */
  .house-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 8px; margin-bottom: 14px; }
  .house-btn { background: var(--green-mid); border: 1px solid var(--gold-border); border-radius: 10px; color: var(--white); padding: 12px 6px; font-family: 'DM Sans', sans-serif; font-weight: 700; cursor: pointer; transition: all 0.15s; }
  .house-btn:hover { border-color: var(--gold); }
  .house-btn.selected { background: var(--gold); color: var(--green); border-color: var(--gold); }
  .group-grid { display: grid; grid-template-columns: repeat(5, 1fr); gap: 8px; }
  .group-btn { background: var(--green-mid); border: 1px solid var(--gold-border); border-radius: 8px; color: var(--white); padding: 10px 4px; font-weight: 700; cursor: pointer; transition: all 0.15s; }
  .group-btn:hover { border-color: var(--gold); }
  .group-btn.selected { background: var(--gold); color: var(--green); }
  .btn { display: block; width: 100%; background: var(--gold); color: var(--green); border: none; border-radius: 10px; padding: 14px; font-family: 'DM Sans', sans-serif; font-size: 1rem; font-weight: 700; cursor: pointer; margin-top: 16px; }
  .btn:disabled { opacity: 0.35; cursor: not-allowed; }
  .btn-ghost { background: transparent; border: 1px solid var(--gold-border); color: var(--gold); }

  /* play screen */
  .status-bar { display: flex; justify-content: space-between; align-items: center; gap: 10px; margin-bottom: 14px; flex-wrap: wrap; }
  .status-pill { font-family: 'DM Mono', monospace; font-size: 11px; letter-spacing: 0.1em; text-transform: uppercase; color: var(--muted); background: rgba(255,255,255,0.06); border: 1px solid rgba(255,255,255,0.12); padding: 7px 12px; border-radius: 99px; }
  .status-pill b { color: var(--gold); font-size: 14px; }
  .strength-board { display: grid; grid-template-columns: repeat(auto-fill, minmax(140px, 1fr)); gap: 8px; }
  .s-card { background: var(--green-mid); border: 1px solid rgba(255,255,255,0.15); border-radius: 10px; padding: 10px 8px; cursor: pointer; transition: all 0.15s; text-align: center; position: relative; }
  .s-card:hover { border-color: var(--gold); transform: translateY(-1px); }
  .s-card .s-name { font-weight: 700; font-size: 0.85rem; line-height: 1.2; color: var(--gold); }
  .s-card .s-virtue { display: inline-block; margin-top: 5px; font-family: 'DM Mono', monospace; font-size: 8.5px; letter-spacing: 0.1em; text-transform: uppercase; padding: 2px 7px; border-radius: 99px; color: var(--white); opacity: 0.9; }
  .s-card.eliminated { opacity: 0.18; pointer-events: none; filter: grayscale(0.8); }
  .q-list { display: flex; flex-wrap: wrap; gap: 8px; }
  .q-chip { background: var(--green-mid); border: 1px solid var(--gold-border); border-radius: 99px; color: var(--white); font-family: 'DM Sans', sans-serif; font-size: 0.82rem; padding: 9px 14px; cursor: pointer; transition: all 0.15s; }
  .q-chip:hover { border-color: var(--gold); }
  .q-chip .q-cost { font-family: 'DM Mono', monospace; font-size: 10px; color: var(--gold); margin-left: 6px; }
  .q-chip.used { opacity: 0.25; pointer-events: none; text-decoration: line-through; }
  .answer-log { max-height: 160px; overflow-y: auto; display: flex; flex-direction: column; gap: 6px; }
  .log-row { font-size: 0.85rem; line-height: 1.4; padding: 8px 12px; border-radius: 8px; background: rgba(255,255,255,0.05); border-left: 3px solid var(--gold-border); }
  .log-row b.yes { color: var(--correct); } .log-row b.no { color: var(--danger); }
  .hint-line { font-size: 0.8rem; color: var(--muted); margin-top: 10px; }

  /* guess modal */
  .overlay { display: none; position: fixed; inset: 0; background: rgba(0,0,0,0.65); z-index: 50; align-items: center; justify-content: center; padding: 16px; }
  .overlay.open { display: flex; }
  .modal { background: var(--green-mid); border: 1px solid var(--gold-border); border-radius: 14px; padding: 24px; max-width: 380px; width: 100%; text-align: center; }
  .modal h3 { font-family: 'Bebas Neue', sans-serif; font-size: 1.6rem; letter-spacing: 0.05em; color: var(--gold); margin-bottom: 8px; }
  .modal p { font-size: 0.9rem; color: var(--muted); margin-bottom: 16px; }
  .modal-btns { display: flex; gap: 10px; }
  .modal-btns .btn { margin-top: 0; }

  /* result */
  .result-emoji { font-size: 3rem; text-align: center; margin-bottom: 8px; }
  .result-score { font-family: 'Bebas Neue', sans-serif; font-size: 3.4rem; color: var(--gold); text-align: center; letter-spacing: 0.04em; }
  .result-sub { text-align: center; color: var(--muted); font-size: 0.9rem; margin-bottom: 14px; }
  .reveal-card { background: var(--green-mid); border: 1px solid var(--gold-border); border-radius: 12px; padding: 18px; margin: 14px 0; }
  .reveal-name { font-family: 'Bebas Neue', sans-serif; font-size: 1.7rem; letter-spacing: 0.05em; color: var(--gold); }
  .reveal-virtue { font-family: 'DM Mono', monospace; font-size: 10px; letter-spacing: 0.14em; text-transform: uppercase; margin: 4px 0 10px; }
  .reveal-desc { font-size: 0.92rem; line-height: 1.6; color: var(--white); }
  .submit-confirm { display: none; text-align: center; color: var(--correct); font-size: 0.85rem; margin-top: 10px; }
  .footer-note { text-align: center; font-size: 0.72rem; color: var(--muted); margin-top: 18px; line-height: 1.5; }
  @media (max-width: 560px) { .strength-board { grid-template-columns: repeat(2, 1fr); } }
</style>
</head>
<body>
<div class="wrap">
  <div class="header">
    <div class="header-eyebrow">CSHS Homegroup Games</div>
    <h1>GUESS THE <span>STRENGTH</span></h1>
  </div>

  <!-- SIGN IN -->
  <div class="screen active" id="screen-signin">
    <div class="panel">
      <div class="card-title">Choose your house</div>
      <div class="house-grid" id="houseGrid"></div>
      <div class="card-title">Choose your home group</div>
      <div class="group-grid" id="groupGrid"></div>
      <button class="btn" id="startBtn" disabled onclick="beginGame()">Start — one attempt per group per week</button>
    </div>
    <div class="panel">
      <div class="card-title">How to play</div>
      <p style="font-size:0.9rem; line-height:1.6; color:var(--muted);">During Character Strength weeks, one of the 24 character strengths is hidden. Ask yes/no questions to narrow it down — clue questions cost <b style="color:var(--gold)">1 point</b>, virtue questions cost <b style="color:var(--gold)">2</b>. Start with 10 points; a wrong guess costs 2. Tap a strength card when your homegroup is ready to lock in a guess. Same hidden strength for every homegroup this week — choose your questions wisely!</p>
    </div>
  </div>

  <!-- PLAY -->
  <div class="screen" id="screen-play">
    <div class="status-bar">
      <div class="status-pill">Playing: <b id="playerLabel"></b></div>
      <div class="status-pill">Score: <b id="scoreLabel">10</b>/10</div>
      <div class="status-pill" id="weekLabel"></div>
    </div>
    <div class="panel">
      <div class="card-title">Ask a question</div>
      <div class="q-list" id="qList"></div>
      <div class="hint-line">Cards grey out automatically as answers rule them out.</div>
    </div>
    <div class="panel">
      <div class="card-title">Answers so far</div>
      <div class="answer-log" id="answerLog"><div class="log-row" style="color:var(--muted)">No questions asked yet.</div></div>
    </div>
    <div class="panel">
      <div class="card-title">The suspects — tap one to lock in a guess</div>
      <div class="strength-board" id="board"></div>
    </div>
  </div>


  <!-- NON-STRENGTH WEEK -->
  <div class="screen" id="screen-nonplay">
    <div class="panel" style="text-align:center;">
      <div class="card-title">This week's focus</div>
      <div class="result-emoji">🎮</div>
      <div class="reveal-name" id="nonPlayTitle">Not a Character Strength week</div>
      <div class="reveal-virtue" id="nonPlayWeek"></div>
      <div class="reveal-desc" id="nonPlayDesc" style="margin-top:12px;"></div>
      <p style="font-size:0.92rem; line-height:1.6; color:var(--muted); margin-top:16px;">
        Guess the Strength is only available during weeks with a specific Character Strength focus.
        Head back to the games page and choose another Home Group game for this week.
      </p>
      <button class="btn" onclick="goToGamesPage()">Back to Games Page</button>
      <button class="btn btn-ghost" onclick="resetToSignin()">Back to sign-in</button>
    </div>
  </div>

  <!-- RESULT -->
  <div class="screen" id="screen-result">
    <div class="panel">
      <div class="result-emoji" id="resultEmoji">🎉</div>
      <div class="result-score" id="finalScore">10</div>
      <div class="result-sub" id="resultDetail"></div>
      <div class="reveal-card">
        <div class="reveal-name" id="revealName"></div>
        <div class="reveal-virtue" id="revealVirtue"></div>
        <div class="reveal-desc" id="revealDesc"></div>
      </div>
      <button class="btn" id="submitScoreBtn" onclick="submitScoreGTS()">Submit score to leaderboard</button>
      <div class="submit-confirm" id="submitConfirm" role="status" aria-live="polite">✓ Form opened in a new tab — press Submit there to finish.</div>
      <button class="btn btn-ghost" onclick="resetToSignin()">Back to sign-in</button>
    </div>
  </div>

  <div class="footer-note">Based on the VIA Classification of Character Strengths · Not affiliated with the VIA Institute on Character</div>
</div>

<!-- GUESS CONFIRM -->
<div class="overlay" id="guessOverlay">
  <div class="modal">
    <h3 id="guessName">Strength</h3>
    <p>Lock in this guess? A wrong guess costs 2 points.</p>
    <div class="modal-btns">
      <button class="btn btn-ghost" onclick="cancelGuess()">Cancel</button>
      <button class="btn" onclick="confirmGuess()">Lock it in</button>
    </div>
  </div>
</div>

<script src="../../assets/site-config.js"></script>
<script>
// Opens the score form. Returns false if the browser blocked the new tab, in
// which case a real link is shown instead — clicking a link is never blocked.
function cshsOpenForm(url){
  var w=null;
  try{ w=window.open(url,'_blank'); }catch(e){ w=null; }
  var box=document.getElementById('cshsFormFallback');
  if(w){ if(box){ box.style.display='none'; } return true; }
  // Runs after the caller's own "submitted" messaging, so it can correct it.
  setTimeout(function(){
    var confirmEl=document.getElementById('submitConfirm');
    if(confirmEl){ confirmEl.style.display='none'; }
    var b=document.getElementById('cshsFormFallback');
    if(!b){
      b=document.createElement('div');
      b.id='cshsFormFallback';
      b.setAttribute('role','alert');
      b.style.cssText='margin:12px 0;padding:12px 14px;border:1px solid rgba(242,180,0,.5);'+
        'border-radius:10px;background:rgba(242,180,0,.12);text-align:center;';
      var msg=document.createElement('div');
      msg.style.cssText='font-size:13px;line-height:1.5;color:#fdfdfd;margin-bottom:9px;';
      msg.textContent='Your browser blocked the new tab, so the score form did not open. '+
        'Use this link instead — your score is already filled in.';
      var a=document.createElement('a');
      a.id='cshsFormFallbackLink';
      a.target='_blank'; a.rel='noopener';
      a.textContent='Open the score form';
      a.style.cssText='display:inline-block;padding:9px 18px;border-radius:8px;background:#f2b400;'+
        'color:#00180f;font-weight:700;font-size:14px;text-decoration:none;';
      b.appendChild(msg); b.appendChild(a);
      var anchor=document.getElementById('submitScoreBtn')||document.getElementById('submitBtn')||
                 document.querySelector('#score-form button');
      if(anchor&&anchor.parentNode){ anchor.parentNode.insertBefore(b,anchor.nextSibling); }
      else{ document.body.appendChild(b); }
    }
    document.getElementById('cshsFormFallbackLink').href=url;
    b.style.display='';
    try{ b.scrollIntoView({block:'nearest'}); }catch(e){}
  },0);
  return false;
}

/* ── SUITE CONSTANTS (shared with all CSHS games) ── */
const CSHS_FORM_BASE = 'https://forms.cloud.microsoft/Pages/ResponsePage.aspx';
const CSHS_FORM_ID = 'xccAZrUWr0uekzI72MAduqpmcw_jVYVCjN05AfEP1IdUOUtFVUJQOFhZWjRZNjAzRkMyWlozTUpTUy4u';
const CSHS_F_WEEK = 'rb28fecc633264af694f45d8cf2b3b8c1', CSHS_F_GAME = 'rdbbd457b83da425e93f978536b950482';
const CSHS_F_HOUSE = 'rd04d4cf9da8a4213820791f91cdcf6ba', CSHS_F_GROUP = 'r3022db1950b649218496e706728c203f';
const CSHS_F_SCORE = 'r8b61653d0854482a9e7e329026083f7b';

const CSHS_TERMS = window.CSHS_SITE_CONFIG.terms;
function parseISO(s){const [y,m,d]=s.split('-').map(Number);return new Date(y,m-1,d);}
function mondayOf(d){const x=new Date(d);const dow=(x.getDay()+6)%7;x.setDate(x.getDate()-dow);x.setHours(0,0,0,0);return x;}
function cshsWeekInfo(){
  const today=new Date(); today.setHours(0,0,0,0);
  let chosen={t:1,w:1}, abs=0, chosenAbs=0;
  for(const term of CSHS_TERMS){
    const end=parseISO(term.end); let mon=mondayOf(parseISO(term.start)); let w=1;
    while(mon<=end){
      abs+=1;
      if(mon<=today){chosen={t:term.t,w};chosenAbs=abs;}
      mon=new Date(mon); mon.setDate(mon.getDate()+7); w+=1;
    }
  }
  return {label:`Term ${chosen.t} \u00b7 Week ${chosen.w}`, abs: chosenAbs||1, t: chosen.t, w: chosen.w};
}
function cshsWeekLabel(){ return cshsWeekInfo().label; }

/* ── STRENGTH DATA ── */
const VC = { Wisdom:'var(--w)', Courage:'var(--c)', Humanity:'var(--h)', Justice:'var(--j)', Temperance:'var(--t)', Transcendence:'var(--tr)' };
const STRENGTHS = [
 {id:'creativity',name:'Creativity',virtue:'Wisdom',desc:'Coming up with ideas is your natural mode. When something isn\'t working, your instinct is to invent a different route rather than push harder down the existing one.'},
 {id:'curiosity',name:'Curiosity',virtue:'Wisdom',desc:'Unanswered questions bother you in the best way. New topics, places, and ideas pull you in, and you\'d rather investigate something than leave it unexplained.'},
 {id:'judgement',name:'Judgement',virtue:'Wisdom',desc:'You weigh things up before you commit to a view. Evidence matters more to you than first impressions, and being shown you were wrong feels useful rather than threatening.'},
 {id:'learning',name:'Love of Learning',virtue:'Wisdom',desc:'Adding to what you know is genuinely satisfying, whether or not anyone is grading it. You build skills and knowledge for their own sake.'},
 {id:'perspective',name:'Perspective',virtue:'Wisdom',desc:'You tend to see how the pieces of a situation fit together, which is why people seek your take when things get complicated.'},
 {id:'bravery',name:'Bravery',virtue:'Courage',desc:'Discomfort doesn\'t decide your actions. Whether it\'s a hard conversation or an unpopular stance, you\'d rather act on your convictions than stay safely quiet.'},
 {id:'perseverance',name:'Perseverance',virtue:'Courage',desc:'Once you\'ve started something, abandoning it doesn\'t sit right. Obstacles tend to sharpen your focus rather than drain it.'},
 {id:'honesty',name:'Honesty',virtue:'Courage',desc:'What people see from you is what\'s actually there. You\'d rather deliver an uncomfortable truth than maintain a comfortable pretence.'},
 {id:'zest',name:'Zest',virtue:'Courage',desc:'You bring energy with you. Days feel like something to be used rather than gotten through, and your enthusiasm tends to be contagious.'},
 {id:'love',name:'Love',virtue:'Humanity',desc:'The people closest to you are central to how you live, not an accessory to it. You invest in those relationships openly.'},
 {id:'kindness',name:'Kindness',virtue:'Humanity',desc:'Helping is your default setting. You notice what others need, often before they ask.'},
 {id:'social',name:'Social Intelligence',virtue:'Humanity',desc:'You read rooms well. Shifts in mood, unspoken tension, what someone actually means — you pick these up quickly.'},
 {id:'teamwork',name:'Teamwork',virtue:'Justice',desc:'When you\'re part of a group, the group\'s result becomes your result. People learn quickly that you can be counted on.'},
 {id:'fairness',name:'Fairness',virtue:'Justice',desc:'Even-handedness matters to you on principle. You apply the same standards to people you like and people you don\'t.'},
 {id:'leadership',name:'Leadership',virtue:'Justice',desc:'When a group needs direction, you\'re willing to provide it — and you make sure nobody gets left on the outside while it happens.'},
 {id:'forgiveness',name:'Forgiveness',virtue:'Temperance',desc:'You give people a way back. Holding onto resentment strikes you as a poor trade.'},
 {id:'humility',name:'Humility',virtue:'Temperance',desc:'You don\'t need to be the headline. Your work can speak for itself, and you take feedback without bristling.'},
 {id:'prudence',name:'Prudence',virtue:'Temperance',desc:'You look before you leap, habitually. Choices get weighed against where they lead, not just how they feel right now.'},
 {id:'regulation',name:'Self-Regulation',virtue:'Temperance',desc:'You run yourself with discipline. Impulses and moods get a vote but not a veto.'},
 {id:'appreciation',name:'Appreciation of Beauty',virtue:'Transcendence',desc:'Quality stops you in your tracks — a striking sky, a piece of music, someone doing difficult work superbly.'},
 {id:'gratitude',name:'Gratitude',virtue:'Transcendence',desc:'You keep track of the good in your life rather than taking it as given, and you make sure people know what they\'ve meant to you.'},
 {id:'hope',name:'Hope',virtue:'Transcendence',desc:'You treat the future as something to build, not something that happens to you. Your optimism comes with effort attached.'},
 {id:'humour',name:'Humour',virtue:'Transcendence',desc:'You find the light side and you share it. You can take the heaviness out of a room without taking the substance out of it.'},
 {id:'spirituality',name:'Spirituality',virtue:'Transcendence',desc:'Your life is organised around a sense of meaning that goes beyond the day-to-day.'}
];

/* ── QUESTION BANK ──
   Each question has a deterministic YES-set. Virtue questions cost 2, clue questions cost 1. */
const QUESTIONS = [
 {q:'Is it in the Virtue of Wisdom?', cost:2, yes:['creativity','curiosity','judgement','learning','perspective']},
 {q:'Is it in the Virtue of Courage?', cost:2, yes:['bravery','perseverance','honesty','zest']},
 {q:'Is it in the Virtue of Humanity?', cost:2, yes:['love','kindness','social']},
 {q:'Is it in the Virtue of Justice?', cost:2, yes:['teamwork','fairness','leadership']},
 {q:'Is it in the Virtue of Temperance?', cost:2, yes:['forgiveness','humility','prudence','regulation']},
 {q:'Is it in the Virtue of Transcendence?', cost:2, yes:['appreciation','gratitude','hope','humour','spirituality']},
 {q:'Is it mainly about how you treat or connect with other people?', cost:1, yes:['love','kindness','social','teamwork','fairness','leadership','forgiveness','gratitude','humour']},
 {q:'Is it mainly about thinking or learning?', cost:1, yes:['creativity','curiosity','judgement','learning','perspective','prudence']},
 {q:'Is it about holding back or staying in control of yourself?', cost:1, yes:['forgiveness','humility','prudence','regulation']},
 {q:'Does it involve energy or enthusiasm?', cost:1, yes:['zest','hope','humour','bravery']},
 {q:'Is it about the future?', cost:1, yes:['hope','prudence']},
 {q:'Would a team captain especially need it?', cost:1, yes:['leadership','teamwork','fairness','perseverance','social']},
 {q:'Is it about noticing or appreciating things?', cost:1, yes:['appreciation','gratitude','curiosity']},
 {q:'Is it hardest to use when you\'re angry?', cost:1, yes:['forgiveness','regulation','fairness','judgement','prudence']},
 {q:'Is it about fun, laughter, or play?', cost:1, yes:['humour','zest']},
 {q:'Is it about being true to yourself?', cost:1, yes:['honesty','humility','spirituality','bravery']},
 {q:'Is it about imagining or inventing things?', cost:1, yes:['creativity']},
 {q:'Is it about giving advice or seeing the big picture?', cost:1, yes:['perspective','judgement']},
 {q:'Is it about being in charge of a group?', cost:1, yes:['leadership']},
 {q:'Is it about close relationships, like family and best friends?', cost:1, yes:['love']}
];

/* ── WEEKLY SECRET ──
   Playable only on weeks with a specific Character Strength focus, aligned
   to the 2026 Corinda SHS Positive Education focus-strength schedule. */
const GAMES_HUB_URL = window.CSHS_SITE_CONFIG.gamesHubUrl;

const WEEK_PLAN_GTS = {
  /* Humanity */
  '1-6':'love',
  '1-7':'social',
  '1-8':'kindness',
  /* Transcendence */
  '1-10':'humour',
  '2-1':'spirituality',
  '2-2':'appreciation',
  '2-3':'hope',
  '2-4':'gratitude',
  /* Wisdom */
  '2-6':'learning',
  '2-7':'perspective',
  '2-8':'curiosity',
  '2-9':'creativity',
  '2-10':'judgement',
  /* Justice */
  '3-4':'leadership',
  '3-5':'fairness',
  '3-6':'teamwork',
  /* Courage */
  '3-8':'zest',
  '3-9':'bravery',
  '3-10':'perseverance',
  '4-1':'honesty',
  /* Temperance */
  '4-4':'prudence',
  '4-5':'humility',
  '4-6':'regulation',
  '4-7':'forgiveness'
};

const NON_PLAY_WEEKS = {
  '1-1':{title:'Welcome back', desc:'This week is about settling in and starting the year well.'},
  '1-2':{title:'Positive Education introduction', desc:'This week introduces Positive Education and why it matters in Home Group.'},
  '1-3':{title:'PERMAH pillars overview', desc:'This week explores the PERMAH pillars that support wellbeing.'},
  '1-4':{title:'Virtues and character strengths overview', desc:'This week introduces the six virtues and the 24 character strengths.'},
  '1-5':{title:'Virtue of Humanity', desc:'This week introduces Humanity: the strengths that help us build kind, positive connections.'},
  '1-9':{title:'Virtue of Transcendence', desc:'This week introduces Transcendence: the strengths that connect us with purpose, hope and meaning.'},
  '2-5':{title:'Virtue of Wisdom', desc:'This week introduces Wisdom: the strengths that help us think, learn and make sense of the world.'},
  '3-1':{title:'Virtues recap', desc:'This week revisits Humanity, Transcendence and Wisdom before moving into the next virtues.'},
  '3-2':{title:'PERMAH overview', desc:'This week recaps the PERMAH wellbeing framework.'},
  '3-3':{title:'Virtue of Justice', desc:'This week introduces Justice: the strengths that help groups work fairly and effectively.'},
  '3-7':{title:'Virtue of Courage', desc:'This week introduces Courage: the strengths that help us act bravely and persist through challenge.'},
  '4-2':{title:'Courage review', desc:'This week reviews the Courage strengths covered in the program.'},
  '4-3':{title:'Virtue of Temperance', desc:'This week introduces Temperance: the strengths that help us show balance, self-control and good judgement.'},
  '4-8':{title:'Year in review', desc:'This week reviews PERMAH, the six virtues and the character strengths explored this year.'}
};

function weekKey(){
  const info = cshsWeekInfo();
  return info.t + '-' + info.w;
}
function secretForThisWeek(){
  const id = WEEK_PLAN_GTS[weekKey()];
  return id ? STRENGTHS.find(s => s.id === id) : null;
}
function nonPlayForThisWeek(){
  return NON_PLAY_WEEKS[weekKey()] || {title:'Not a Character Strength week', desc:'This week does not have one specific Character Strength focus.'};
}
function goToGamesPage(){
  window.location.href = GAMES_HUB_URL;
}
/* ── STATE ── */
const HOUSES = ['Bunar','Dibbil','Kabul','Moori','Pirri','Yarraman'];
const GROUP_LETTERS = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','Staff'];
let selectedHouse = null, selectedGroup = null;
let secret = null, score = 10, eliminated = new Set(), askedCount = 0, gameOver = false;
let pendingGuess = null;

/* ── WEEKLY LOCK (per device, mirrors the rest of the suite) ── */
function lockKey(){ return 'cshs-gts-' + cshsWeekLabel(); }
function readPlayed(){ try { return JSON.parse(localStorage.getItem(lockKey()) || '[]'); } catch(e){ return []; } }
function writePlayed(list){ try { localStorage.setItem(lockKey(), JSON.stringify(list)); } catch(e){} }
function groupName(){ return selectedGroup === 'Staff' ? 'Staff' : selectedHouse + ' ' + selectedGroup; }

/* ── SIGN IN ── */
function buildSignin(){
  const hg = document.getElementById('houseGrid');
  hg.innerHTML = '';
  HOUSES.forEach(hn => {
    const b = document.createElement('button');
    b.className = 'house-btn'; b.type = 'button'; b.textContent = hn;
    b.addEventListener('click', () => { selectedHouse = hn;
      hg.querySelectorAll('.house-btn').forEach(x => x.classList.toggle('selected', x.textContent === hn));
      checkSignin(); });
    hg.appendChild(b);
  });
  const gg = document.getElementById('groupGrid');
  gg.innerHTML = '';
  GROUP_LETTERS.forEach(l => {
    const b = document.createElement('button');
    b.className = 'group-btn'; b.type = 'button'; b.textContent = l;
    b.addEventListener('click', () => { selectedGroup = l;
      gg.querySelectorAll('.group-btn').forEach(x => x.classList.toggle('selected', x.textContent === l));
      checkSignin(); });
    gg.appendChild(b);
  });
}
function checkSignin(){
  document.getElementById('startBtn').disabled = !(selectedGroup === 'Staff' ? true : (selectedHouse && selectedGroup));
}

function beginGame(){
  if (selectedGroup !== 'Staff' && !selectedHouse) return;
  const g = groupName();
  secret = secretForThisWeek();
  if (!secret) {
    showNonPlayScreen();
    return;
  }
  if (selectedGroup !== 'Staff') {
    const played = readPlayed();
    if (played.includes(g)) {
      alert(g + ' has already played Guess the Strength on this browser for ' + cshsWeekLabel() + '. Choose Staff for practice, or come back next week.');
      return;
    }
  }
  score = 10; eliminated = new Set(); askedCount = 0; gameOver = false;
  document.getElementById('playerLabel').textContent = g;
  document.getElementById('weekLabel').textContent = cshsWeekLabel();
  document.getElementById('scoreLabel').textContent = score;
  document.getElementById('answerLog').innerHTML = '<div class="log-row" style="color:var(--muted)">No questions asked yet.</div>';
  buildBoard(); buildQuestions();
  showScreen('screen-play');
}

function showNonPlayScreen(){
  const info = nonPlayForThisWeek();
  document.getElementById('nonPlayTitle').textContent = info.title;
  document.getElementById('nonPlayWeek').textContent = cshsWeekLabel();
  document.getElementById('nonPlayDesc').textContent = info.desc;
  showScreen('screen-nonplay');
}

function showScreen(id){
  document.querySelectorAll('.screen').forEach(s => s.classList.toggle('active', s.id === id));
  window.scrollTo({top:0});
}

/* ── BOARD + QUESTIONS ── */
function buildBoard(){
  const board = document.getElementById('board');
  board.innerHTML = '';
  STRENGTHS.forEach(s => {
    const c = document.createElement('button');
    c.type = 'button'; c.className = 's-card'; c.id = 'sc-' + s.id;
    c.innerHTML = `<div class="s-name">${s.name}</div><span class="s-virtue" style="background:${VC[s.virtue]}">${s.virtue}</span>`;
    c.addEventListener('click', () => openGuess(s.id));
    board.appendChild(c);
  });
}
function buildQuestions(){
  const list = document.getElementById('qList');
  list.innerHTML = '';
  QUESTIONS.forEach((qu, i) => {
    const chip = document.createElement('button');
    chip.type = 'button'; chip.className = 'q-chip'; chip.id = 'q-' + i;
    chip.innerHTML = `${qu.q}<span class="q-cost">\u2212${qu.cost}</span>`;
    chip.addEventListener('click', () => askQuestion(i));
    list.appendChild(chip);
  });
}

function askQuestion(i){
  if (gameOver) return;
  const qu = QUESTIONS[i];
  const chip = document.getElementById('q-' + i);
  if (chip.classList.contains('used')) return;
  chip.classList.add('used');
  askedCount += 1;
  score = Math.max(0, score - qu.cost);
  document.getElementById('scoreLabel').textContent = score;
  const isYes = qu.yes.includes(secret.id);
  // eliminate the ruled-out side
  STRENGTHS.forEach(s => {
    const inSet = qu.yes.includes(s.id);
    if (isYes !== inSet) {
      eliminated.add(s.id);
      document.getElementById('sc-' + s.id).classList.add('eliminated');
    }
  });
  logAnswer(qu.q, isYes);
}

function logAnswer(qText, isYes){
  const log = document.getElementById('answerLog');
  if (askedCount === 1) log.innerHTML = '';
  const row = document.createElement('div');
  row.className = 'log-row';
  row.innerHTML = `${qText} <b class="${isYes ? 'yes' : 'no'}">${isYes ? 'YES' : 'NO'}</b>`;
  log.prepend(row);
}

/* ── GUESSING ── */
function openGuess(sid){
  if (gameOver || eliminated.has(sid)) return;
  pendingGuess = sid;
  document.getElementById('guessName').textContent = STRENGTHS.find(s => s.id === sid).name;
  document.getElementById('guessOverlay').classList.add('open');
}
function cancelGuess(){
  pendingGuess = null;
  document.getElementById('guessOverlay').classList.remove('open');
}
function confirmGuess(){
  const sid = pendingGuess;
  document.getElementById('guessOverlay').classList.remove('open');
  pendingGuess = null;
  if (!sid || gameOver) return;
  if (sid === secret.id) {
    finishGame(true);
  } else {
    score = Math.max(0, score - 2);
    document.getElementById('scoreLabel').textContent = score;
    eliminated.add(sid);
    document.getElementById('sc-' + sid).classList.add('eliminated');
    logAnswer('Is it ' + STRENGTHS.find(s => s.id === sid).name + '?', false);
    if (score === 0) { finishGame(false); return; }
  }
}

function finishGame(won){
  gameOver = true;
  if (selectedGroup !== 'Staff') {
    const played = readPlayed();
    const g = groupName();
    if (!played.includes(g)) { played.push(g); writePlayed(played); }
  }
  window._lastResult = { group: groupName(), score: score, house: selectedHouse || 'Staff' };
  document.getElementById('resultEmoji').textContent = won ? (score >= 8 ? '\uD83C\uDFC6' : '\uD83C\uDF89') : '\u23F0';
  document.getElementById('finalScore').textContent = score;
  document.getElementById('resultDetail').textContent = won
    ? `Solved with ${askedCount} question${askedCount === 1 ? '' : 's'} asked \u2014 ${score} out of 10`
    : 'Out of points';
  document.getElementById('revealName').textContent = secret.name;
  const rv = document.getElementById('revealVirtue');
  rv.textContent = 'Virtue of ' + secret.virtue;
  rv.style.color = VC[secret.virtue];
  document.getElementById('revealDesc').textContent = secret.desc;
  document.getElementById('submitScoreBtn').textContent = 'Submit score to leaderboard';
  document.getElementById('submitScoreBtn').disabled = false;
  document.getElementById('submitConfirm').style.display = 'none';
  showScreen('screen-result');
}

/* ── SUBMIT (standard suite prefill) ── */
function submitScoreGTS(){
  const r = window._lastResult;
  if (!r) return;
  const params = new URLSearchParams({
    id: CSHS_FORM_ID,
    [CSHS_F_WEEK]: cshsWeekLabel(),
    [CSHS_F_GAME]: 'Guess the Strength',
    [CSHS_F_HOUSE]: r.house,
    [CSHS_F_GROUP]: r.group,
    [CSHS_F_SCORE]: String(r.score)
  });
  cshsOpenForm(CSHS_FORM_BASE + '?' + params.toString());
  document.getElementById('submitConfirm').style.display = 'block';
  document.getElementById('submitScoreBtn').textContent = '↗ Reopen form';
  document.getElementById('submitScoreBtn').disabled = false;
}

function resetToSignin(){
  selectedHouse = null; selectedGroup = null;
  buildSignin(); checkSignin();
  showScreen('screen-signin');
}

buildSignin();
</script>
</body>
</html>
