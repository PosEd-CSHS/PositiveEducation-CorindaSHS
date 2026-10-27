<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Weekly Trivia – CSHS</title>
<script src="../../assets/site-config.js"></script>
<style>
  @import url('../../assets/fonts/fonts.css');
  :root{
    --green:#00180f;--green-mid:#003d1f;--green-light:#005a2e;
    --gold:#f2b400;--gold-dim:rgba(242,180,0,0.15);--gold-border:rgba(242,180,0,0.3);
    --white:#fdfdfd;--muted:rgba(255,255,255,0.68);--danger:#e05252;--correct:#4caf7a;
  }
  *{box-sizing:border-box;margin:0;padding:0;}
  body{font-family:'DM Sans',system-ui,-apple-system,Segoe UI,Arial,sans-serif;background:var(--green);color:var(--white);min-height:100vh;display:flex;flex-direction:column;align-items:center;padding:24px 16px;}
  .header{text-align:center;margin-bottom:18px;}
  .header-eyebrow{font-family:'DM Mono',monospace;font-size:11px;letter-spacing:.18em;text-transform:uppercase;color:var(--gold);margin-bottom:6px;}
  .header h1{font-family:'Bebas Neue',Impact,sans-serif;font-size:clamp(2.4rem,9vw,4rem);letter-spacing:.06em;color:var(--white);line-height:.95;}
  .header h1 span{color:var(--gold);}
  .header-sub{font-size:13px;color:var(--muted);margin-top:8px;max-width:520px;}
  .card{background:rgba(255,255,255,0.04);border:1px solid rgba(255,255,255,0.08);border-radius:16px;padding:22px;margin-bottom:16px;width:100%;max-width:560px;}
  .week-tag{font-family:'DM Mono',monospace;font-size:11px;letter-spacing:.15em;text-transform:uppercase;color:var(--gold);text-align:center;margin-bottom:14px;}
  .timer{font-family:'DM Mono',monospace;font-size:22px;font-weight:700;letter-spacing:.06em;color:var(--white);text-align:center;margin-bottom:12px;}
  .bonus-line{font-family:'DM Mono',monospace;font-size:13px;color:var(--gold);text-align:center;margin-bottom:6px;}
  .progress{display:flex;justify-content:center;gap:6px;margin-bottom:16px;}
  .progress .dot{width:9px;height:9px;border-radius:50%;background:rgba(255,255,255,0.15);}
  .progress .dot.done{background:var(--gold);}
  .progress .dot.current{background:var(--white);}
  .stage-label{font-family:'DM Mono',monospace;font-size:11px;letter-spacing:.16em;text-transform:uppercase;color:var(--muted);text-align:center;margin-bottom:10px;}
  .question-box{background:#fdfdfd;color:#00180f;border:3px solid var(--gold);border-radius:16px;min-height:96px;display:flex;align-items:center;justify-content:center;text-align:center;margin-bottom:16px;padding:18px;box-shadow:0 10px 30px rgba(0,0,0,.18);}
  .question-text{font-size:1.05rem;font-weight:700;line-height:1.4;}
  .rebus-clue{width:100%;display:flex;align-items:center;justify-content:center;gap:.3em;flex-wrap:wrap;font-family:'DM Mono','Arial Black',system-ui,sans-serif;font-weight:800;line-height:1.1;font-size:clamp(1.8rem,9vw,3.4rem);letter-spacing:.02em;}
  .rebus-stack{width:100%;}
  .rebus-hint{margin-top:10px;font-family:system-ui,Arial,sans-serif;font-size:.85rem;font-weight:600;color:#3d5a4a;text-align:center;}
  .rebus-clue .stack{display:inline-flex;flex-direction:column;align-items:center;line-height:1;gap:.08em;}
  .rebus-clue .giant{font-size:1.45em;}
  .rebus-clue .tall{display:inline-block;transform:scaleY(1.9);transform-origin:center;margin:.35em 0;}
  .rebus-clue .line.short{width:min(14vw,90px);}
  .rebus-clue .counting{font-size:.85em;letter-spacing:.08em;}
  .rebus-clue .stack>span,.rebus-clue .word{white-space:nowrap;}
  .rebus-clue .spaced{letter-spacing:.9em;margin-right:-.9em;}
  .rebus-clue .long{font-size:.72em;}
  .rebus-clue .histo{font-size:.5em;font-style:italic;}
  .rebus-clue .readline{display:inline-flex;align-items:center;font-size:.8em;}
  .rebus-clue .vbar{display:inline-block;width:3px;height:1.1em;background:#00180f;margin:0 .12em;}
  .rebus-clue .cornerbox{position:relative;display:inline-block;width:2.4em;height:2.4em;border:5px solid #00180f;border-radius:.5em;}
  .rebus-clue .cornerbox .just{position:absolute;right:.1em;bottom:.2em;font-size:.4em;font-weight:900;transform:rotate(-45deg);}
  .rebus-clue .ovation{font-size:.55em;gap:0;}
  .rebus-clue .compact{font-size:.62em;}
  .rebus-clue .grey{color:#8a8a8a;}
  .rebus-clue .tilt{display:inline-block;transform:rotate(-18deg);margin:.7em .3em .3em;}
  .rebus-clue .tiny{font-size:max(.26em,12px);}
  .rebus-clue .flip{display:inline-block;transform:rotate(180deg);}
  .rebus-clue .lc{font-size:.55em;}
  .rebus-clue .big{font-size:1.35em;}
  .rebus-clue .sup{font-size:.45em;vertical-align:1.3em;}
  .rebus-clue .gap{display:inline-block;width:2.4em;}
  .rebus-clue .hl{font-size:1.25em;color:#d7263d;}
  .rebus-clue .mono{font-family:'Courier New',monospace;font-weight:700;font-size:.8em;}
  .rebus-clue .italic{font-style:italic;letter-spacing:.2em;}
  .rebus-clue .slash{position:relative;}
  .rebus-clue .slash::after{content:'';position:absolute;left:-.1em;right:-.1em;top:50%;border-top:4px solid #d7263d;transform:rotate(-55deg);}
  .rebus-clue .frac{display:inline-flex;flex-direction:column;align-items:center;font-weight:900;line-height:1.1;}
  .rebus-clue .frac>span:first-child{border-bottom:4px solid #00180f;padding:0 .2em;}
  .rebus-clue .overlay{position:relative;display:inline-flex;align-items:center;justify-content:center;}
  .rebus-clue .overlay .bg{font-size:2.6em;line-height:1;}
  .rebus-clue .overlay .fg{position:absolute;font-size:.5em;font-weight:900;color:#fff;text-shadow:0 0 4px #00180f,0 0 4px #00180f;}
  .rebus-clue .sensegrid{display:inline-grid;grid-template-columns:repeat(2,auto);gap:.1em .7em;font-size:.55em;}
  .rebus-clue .circled{border:3px solid #00180f;border-radius:999px;padding:0 .35em;}
  .rebus-clue .cross{display:inline-grid;grid-template-columns:auto auto auto;font-size:.62em;line-height:1.05;align-items:center;justify-items:center;}
  .rebus-clue .cross .c1{justify-self:end;}.rebus-clue .cross .c3{justify-self:start;}
  .rebus-clue .nerves{display:inline-flex;flex-wrap:wrap;justify-content:center;font-size:.55em;gap:.15em .1em;}
  .rebus-clue .nerves span{display:inline-block;}
  .rebus-clue .ring{position:relative;display:inline-block;width:3.2em;height:3.2em;font-size:.8em;margin:.2em;}
  .rebus-clue .small{font-size:.6em;}
  .rebus-clue .huge{font-size:1.4em;}
  .rebus-clue .word{display:inline-block;font-weight:900;}
  .rebus-clue .box{border:4px solid #00180f;border-radius:12px;padding:.15em .25em;display:inline-flex;align-items:center;justify-content:center;}
  .rebus-clue .outside{transform:translateX(-.2em);}
  .rebus-clue .line{display:inline-block;width:min(30vw,180px);height:6px;background:#00180f;border-radius:6px;vertical-align:middle;}
  .rebus-clue .tunnel{letter-spacing:-.2em;}
  .rebus-clue .hrule{display:block;width:3.4em;height:6px;background:#00180f;border-radius:4px;margin:.15em 0;}
  .rebus-clue .sightgrid{display:inline-grid;grid-template-columns:auto auto;column-gap:.5em;align-items:center;justify-items:start;}
  .rebus-clue .sumgrid{display:inline-grid;grid-template-columns:1em repeat(4,.8em);justify-items:center;align-items:center;font-weight:900;line-height:1.15;}
  .rebus-clue .sumgrid .rule{grid-column:1 / span 5;height:6px;width:100%;background:#00180f;border-radius:4px;margin-top:.1em;}
  .rebus-clue .red{color:#d7263d;}
  .char-box{text-align:center;}
  .char-strip{height:190px;margin:0 auto;display:flex;flex-direction:column;border:2px solid #00180f;border-radius:6px;overflow:hidden;background:#fff;}
  .char-note{margin-top:10px;font-size:12px;color:#555;max-width:340px;}
  .music-box{display:flex;flex-direction:column;align-items:center;gap:10px;}
  .music-play-btn{width:auto;margin-bottom:0;padding:16px 32px;font-size:16px;}
  .music-hint{font-family:'DM Mono',monospace;font-size:11px;color:#6b6b63;letter-spacing:.04em;}
  .choices{display:grid;grid-template-columns:1fr;gap:10px;margin-bottom:14px;}
  .answer-input{width:100%;background:var(--green-mid);border:1px solid rgba(255,255,255,0.12);border-radius:10px;color:var(--white);font-family:'DM Sans',sans-serif;font-size:1.05rem;font-weight:700;padding:13px 14px;outline:none;text-align:center;}
  .answer-input:focus{border-color:var(--gold-border);box-shadow:0 0 14px rgba(242,180,0,0.12);}
  .answer-input::placeholder{color:rgba(255,255,255,0.34);font-weight:400;}
  .answer-input:disabled{opacity:.6;}
  .choice-btn{background:var(--gold-dim);border:1px solid var(--gold-border);color:var(--white);padding:13px 16px;border-radius:10px;font-family:'DM Sans',sans-serif;font-size:14px;font-weight:700;cursor:pointer;transition:all .15s;text-align:left;}
  .choice-btn:hover:not(:disabled){background:rgba(242,180,0,0.28);border-color:var(--gold);}
  .choice-btn:disabled{cursor:not-allowed;}
  .choice-btn.correct{background:rgba(76,175,122,0.28);border-color:var(--correct);color:var(--white);}
  .choice-btn.wrong{background:rgba(224,82,82,0.28);border-color:var(--danger);color:var(--white);}
  .feedback{font-family:'DM Mono',monospace;font-size:12px;letter-spacing:.04em;text-align:center;margin-bottom:14px;min-height:1.4em;}
  .feedback.right{color:var(--correct);}.feedback.wrong{color:var(--danger);}
  .note-box{background:var(--gold-dim);border:1px solid var(--gold-border);border-radius:10px;padding:10px 14px;margin-bottom:14px;text-align:center;font-size:12.5px;color:var(--white);display:none;}
  .note-box.show{display:block;}
  .btn{display:inline-flex;align-items:center;justify-content:center;gap:8px;padding:12px 24px;border-radius:10px;font-family:'DM Sans',sans-serif;font-size:14px;font-weight:800;cursor:pointer;border:none;transition:all .15s;letter-spacing:.02em;width:100%;margin-bottom:10px;}
  .btn-primary{background:var(--gold);color:var(--green);}.btn-primary:hover{background:#ffc820;transform:translateY(-1px);}
  .btn-primary:disabled{opacity:.4;cursor:not-allowed;transform:none;}
  .btn-outline{background:transparent;color:var(--gold);border:1px solid var(--gold-border);}.btn-outline:hover{background:var(--gold-dim);}
  .score-panel{text-align:center;}
  .score-big{font-family:'Bebas Neue',sans-serif;font-size:3rem;color:var(--gold);letter-spacing:.04em;line-height:1;margin:10px 0;}
  .score-sub{font-size:13px;color:var(--muted);margin-bottom:18px;}
  .choice-btn:focus-visible,.btn:focus-visible{outline:3px solid var(--gold);outline-offset:2px;}
  .form-label{font-family:'DM Mono',monospace;font-size:11px;letter-spacing:.18em;text-transform:uppercase;color:var(--gold);display:block;margin-bottom:8px;margin-top:14px;}
  .group-select{display:grid;grid-template-columns:repeat(auto-fill,minmax(80px,1fr));gap:8px;margin-bottom:8px;}
  .group-btn{background:var(--gold-dim);border:1px solid var(--gold-border);color:var(--white);padding:8px 6px;border-radius:10px;font-family:'DM Sans',sans-serif;font-size:13px;font-weight:700;cursor:pointer;transition:all .15s;text-align:center;}
  .group-btn:hover{background:rgba(242,180,0,0.28);border-color:var(--gold);}
  .group-btn.selected{background:var(--gold);color:var(--green);border-color:var(--gold);}
  .group-btn[disabled]{opacity:.4;cursor:not-allowed;}
  .lock-notice{display:none;background:rgba(224,82,82,0.12);border:1px solid rgba(224,82,82,0.35);border-radius:10px;padding:12px 16px;margin-bottom:12px;font-size:12px;color:#ffb3b3;text-align:center;font-family:'DM Mono',monospace;line-height:1.5;}
  .lock-notice.show{display:block;}
  .warn-line{font-size:12px;color:var(--muted);text-align:center;margin-bottom:10px;font-family:'DM Mono',monospace;}
  .submit-confirm{display:none;text-align:center;color:var(--correct);font-size:12.5px;margin-top:10px;}
  /* ── Bonus round ── */
  .bonus-intro{font-size:13px;color:var(--muted);text-align:center;margin-bottom:16px;line-height:1.5;}
  .countdown-wrap{display:flex;align-items:center;gap:12px;margin-bottom:14px;}
  .countdown-num{font-family:'Bebas Neue',sans-serif;font-size:1.8rem;color:var(--gold);min-width:2.5ch;text-align:right;line-height:1;}
  .countdown-num.urgent{color:var(--danger);}
  .countdown-track{flex:1;height:6px;background:rgba(255,255,255,0.1);border-radius:3px;overflow:hidden;}
  .countdown-fill{height:100%;background:var(--gold);border-radius:3px;width:100%;transition:background .3s;}
  .countdown-fill.urgent{background:var(--danger);}
  .target-area{text-align:center;margin-bottom:16px;}
  .target-label{font-family:'DM Mono',monospace;font-size:10px;letter-spacing:.18em;text-transform:uppercase;color:var(--muted);margin-bottom:6px;}
  .target-pct{font-family:'Bebas Neue',sans-serif;font-size:clamp(2.2rem,10vw,3.4rem);color:var(--gold);line-height:1;}
  .number-tiles{display:flex;flex-wrap:wrap;gap:8px;justify-content:center;margin-bottom:14px;}
  .num-tile{width:56px;height:56px;background:rgba(255,255,255,0.08);border:2px solid rgba(255,255,255,0.15);border-radius:10px;display:flex;align-items:center;justify-content:center;font-family:'Bebas Neue',sans-serif;font-size:26px;color:var(--white);cursor:pointer;transition:all .15s;user-select:none;}
  .num-tile:hover{background:rgba(242,180,0,0.15);border-color:var(--gold);}
  .num-tile.used{opacity:.25;cursor:not-allowed;pointer-events:none;}
  .num-tile.large-num{background:rgba(242,180,0,0.12);border-color:rgba(242,180,0,0.4);color:var(--gold);}
  .calc-display{background:rgba(0,0,0,0.25);border:1px solid rgba(255,255,255,0.15);border-radius:10px;padding:11px 14px;font-family:'DM Mono',monospace;font-size:15px;color:var(--white);min-height:44px;margin-bottom:10px;word-break:break-all;}
  .calc-grid{display:grid;grid-template-columns:repeat(4,1fr);gap:7px;margin-bottom:12px;}
  .op-btn{padding:12px;border-radius:8px;font-family:'DM Mono',monospace;font-size:16px;font-weight:700;cursor:pointer;border:none;background:rgba(255,255,255,0.08);color:var(--white);}
  .op-btn:hover{background:rgba(255,255,255,0.15);}
  .op-btn.equals{background:var(--gold);color:var(--green);grid-column:span 2;}
  .op-btn.clear{background:rgba(224,82,82,0.2);color:var(--danger);}
  .op-btn.backspace{background:rgba(255,255,255,0.05);color:var(--muted);}
  .bar-track{width:100%;height:56px;background:var(--green-mid);border:1px solid rgba(255,255,255,0.1);border-radius:12px;overflow:hidden;position:relative;cursor:pointer;margin-bottom:14px;user-select:none;touch-action:none;}
  .bar-track.active{border-color:var(--gold-border);}
  .bar-fill{height:100%;background:linear-gradient(90deg,var(--green-light),var(--gold));width:0%;position:relative;}
  .bar-fill::after{content:'';position:absolute;right:0;top:0;bottom:0;width:4px;background:var(--white);}
  .bar-target-line{position:absolute;top:0;bottom:0;width:2px;background:#fff;opacity:0;}
  .bar-target-line.show{opacity:.9;}
  @media (max-width:460px){body{padding:14px 10px}.card{padding:16px}.rebus-clue{font-size:clamp(1.5rem,11vw,2.6rem)}}
</style>
</head>
<body>
<div class="header">
  <div class="header-eyebrow">Corinda State High School</div>
  <h1>Weekly <span>Trivia</span></h1>
  <div class="header-sub">Ten quick rounds for the whole class, mixing this week's focus, Crack the Code, a mystery character, general knowledge, and questions on music, sport, school subjects and TV &amp; movies — some weeks add a music round. Some weeks offer one shot at winning back a missed point.</div>
</div>

<div class="card" id="signinCard">
  <div class="week-tag" id="weekTagSignin">—</div>
  <span class="form-label">House</span><div class="group-select" id="houseSelectBtns"></div>
  <span class="form-label">Home Group</span><div class="group-select" id="groupSelectBtns"></div>
  <div class="lock-notice" id="lockNotice" role="status" aria-live="polite"></div>
  <div class="warn-line">One attempt per home group, per week. Staff can replay freely.</div>
  <button class="btn btn-primary" id="startBtn" disabled>Start Weekly Trivia</button>
</div>

<div class="card" id="playCard" style="display:none">
  <div class="week-tag" id="weekTag">—</div>
  <div class="timer" id="timerDisplay">00:00</div>
  <div class="progress" id="progressDots"></div>

  <div id="playView">
    <div class="stage-label" id="stageLabel">—</div>
    <div class="question-box" id="questionBox"></div>
    <div class="choices" id="choicesBox"></div>
    <div class="feedback" id="feedback"></div>
    <div class="note-box" id="noteBox"></div>
    <button class="btn btn-primary" id="nextBtn" disabled>Next round</button>
  </div>

  <div id="bonusView" style="display:none">
    <div class="stage-label">Bonus round — win a point back</div>
    <div class="bonus-intro" id="bonusIntro"></div>

    <div id="bonusCountdown" style="display:none">
      <div class="countdown-wrap"><div class="countdown-num" id="bcTimerNum">30</div><div class="countdown-track"><div class="countdown-fill" id="bcTimerFill"></div></div></div>
      <div class="target-area"><div class="target-label">Target</div><div class="target-pct" id="bcTarget">—</div></div>
      <div class="number-tiles" id="bcTiles"></div>
      <div class="calc-display" id="bcCalcDisplay">Select a number to begin…</div>
      <div class="calc-grid">
        <button class="op-btn" type="button" id="bcOpPlus">+</button>
        <button class="op-btn" type="button" id="bcOpMinus">−</button>
        <button class="op-btn" type="button" id="bcOpTimes">×</button>
        <button class="op-btn" type="button" id="bcOpDivide">÷</button>
        <button class="op-btn clear" type="button" id="bcClearBtn">Clear</button>
        <button class="op-btn backspace" type="button" id="bcBackBtn">⌫</button>
        <button class="op-btn equals" type="button" id="bcEqualsBtn">=</button>
      </div>
      <button class="btn btn-primary" id="bcSubmitBtn" disabled>Lock in answer</button>
    </div>

    <div class="feedback" id="bonusFeedback"></div>
    <button class="btn btn-primary" id="bonusContinueBtn" style="display:none">See results</button>
  </div>

  <div id="resultView" style="display:none" class="score-panel">
    <div class="stage-label">Weekly Trivia — Results</div>
    <div class="score-big" id="scoreBig">0 / 10</div>
    <div class="bonus-line" id="bonusLine" style="display:none"></div>
    <div class="score-sub" id="scoreSub">—</div>
    <button class="btn btn-primary" id="submitScoreBtn">Submit score to leaderboard</button>
    <div class="submit-confirm" id="submitConfirm" role="status" aria-live="polite">✓ Form opened in a new tab — press Submit there to finish.</div>
    <button class="btn btn-outline" id="playAgainBtn">Play again</button>
    <button class="btn btn-outline" id="backBtn">Back to Home Group games</button>
  </div>
</div>

<script>
const ROUNDS = [{"week":1,"term":1,"weekInTerm":1,"focus":"welcomeBack","plan":["gk","virtue","teen","gk","gk","gk","char","music","gk","rebus"],"virtueQ":{"q":"Which of these is one of the six pillars of wellbeing in the PERMAH model?","choices":["Relationships","Detention","Timetable","Homework"],"a":0},"rebus":{"clue":"<span class=\"stack\"><span><span class=\"word spaced\">TIME</span></span><span><span class=\"word\">ABDE</span></span></span>","answer":"Long time no see","accepted":["long time no see","long time no sea","long time no c"]},"gk":[{"q":"Which two rivers together form Australia's largest river system?","choices":["The Murray and the Darling","The Fitzroy and the Ord","The Swan and the Avon","The Brisbane and the Mary"],"a":0},{"q":"Which shipping route, discovered by Dutch explorers, first brought Europeans to Australia's western coast?","choices":["The Brouwer Route","The Southern Passage","The Trade Winds Route","The Cape Route"],"a":0},{"q":"What do you call a substance that cannot be broken down into simpler substances by chemical means?","choices":["A compound","An element","A mixture","A solution"],"a":1},{"q":"Which of these numbers is irrational (cannot be written as a simple fraction)?","choices":["4","0.5","√2","7/2"],"a":2},{"q":"What is the name of the boundary where two tectonic plates slide past each other, causing earthquakes?","choices":["A subduction zone","A transform fault","A mid-ocean ridge","A hotspot"],"a":1}],"challenge":null,"music":{"notes":[["C4",1],["C4",1],["G4",1],["G4",1],["A4",1],["A4",1],["G4",2],["F4",1],["F4",1]],"tempoMs":220,"choices":["Old MacDonald Had a Farm","Happy Birthday","Twinkle Twinkle Little Star","Mary Had a Little Lamb"],"a":2},"bonus":null,"teen":{"label":"Sport","q":"How many players does one rugby league team have on the field at a time?","choices":["11","15","13","18"],"a":2},"char":{"name":"Ariel","aspect":0.47,"bands":[["#c3231a",0.17],["#ebc08a",0.22],["#8b6fe6",0.11],["#ebc08a",0.08],["#5cd0a2",0.03],["#0b8a2c",0.27],["#5bd3a3",0.12]],"accepted":["ariel","the little mermaid","little mermaid","princess ariel","ariel the little mermaid","ariel little mermaid"]}},{"week":2,"term":1,"weekInTerm":2,"focus":"posEdIntro","plan":["gk","gk","gk","rebus","gk","gk","gk","virtue","teen","gk"],"virtueQ":{"q":"Positive Education is mainly the study of —","choices":["mental illness only","what makes people and communities flourish, alongside what goes wrong","exam technique","school uniform policy"],"a":1},"rebus":{"clue":"<span class=\"word\">MILL<span class=\"hl\">1</span>ON</span>","answer":"One in a million","accepted":["one in a million","1 in a million","one in a milion"]},"gk":[{"q":"Which Australian mountain is the country's tallest?","choices":["Mount Bogong","Mount Kosciuszko","Mount Buffalo","Mount Feathertop"],"a":1},{"q":"In which year did the Sydney Opera House officially open?","choices":["1956","1965","1973","1988"],"a":2},{"q":"Which gland in the human body regulates metabolism and produces thyroxine?","choices":["Pituitary gland","Thyroid gland","Adrenal gland","Pancreas"],"a":1},{"q":"Which shape is formed when you cross-section a cylinder parallel to its base?","choices":["A square","A triangle","A circle","A rectangle"],"a":2},{"q":"Which landform is created when a river erodes a horseshoe bend and cuts it off from the main channel?","choices":["A meander","An oxbow lake","A floodplain","A watershed"],"a":1},{"q":"How many players does a rugby union team have on the field at one time?","choices":["11","13","15","17"],"a":2},{"q":"Who composed the famous 'Ninth Symphony', including the 'Ode to Joy'?","choices":["Wolfgang Amadeus Mozart","Ludwig van Beethoven","Johann Sebastian Bach","Franz Schubert"],"a":1}],"challenge":null,"music":null,"bonus":null,"teen":{"label":"TV & movies","q":"Which Disney Pixar film follows a boy named Miguel who travels to the Land of the Dead?","choices":["Coco","Encanto","Moana","Soul"],"a":0}},{"week":3,"term":1,"weekInTerm":3,"focus":"permahOverview","plan":["gk","char","virtue","teen","gk","gk","gk","gk","rebus","gk"],"virtueQ":{"q":"In the PERMAH model, what does the letter 'M' stand for?","choices":["Motivation","Meaning","Mindfulness","Money"],"a":1},"rebus":{"clue":"<span class=\"stack\"><span><span class=\"word\">WEATHER</span></span><span><span class=\"word small\">BIT</span></span></span>","answer":"Bit under the weather","accepted":["bit under the weather","a bit under the weather","under the weather","feeling under the weather","bit under weather"]},"gk":[{"q":"Which Australian state has the smallest population of the mainland states?","choices":["Western Australia","South Australia","Victoria","Queensland"],"a":1},{"q":"In which year did the First World War begin?","choices":["1905","1914","1918","1922"],"a":1},{"q":"Which of these units measures energy?","choices":["Newton","Pascal","Joule","Watt"],"a":2},{"q":"How many degrees do the interior angles of a triangle always add up to?","choices":["90","180","270","360"],"a":1},{"q":"What do you call the line on a map joining points of equal elevation?","choices":["An isobar","A contour line","A meridian","A gradient line"],"a":1},{"q":"Which Australian city is served by the Yarra River, and hosts the Australian Open tennis?","choices":["Sydney","Melbourne","Perth","Adelaide"],"a":1}],"challenge":null,"music":null,"bonus":{"kind":"countdown","numbers":[9,7,25,100,5,10],"target":844},"teen":{"label":"Music","q":"Which artist released the 2022 album 'Midnights'?","choices":["Olivia Rodrigo","Taylor Swift","Billie Eilish","Dua Lipa"],"a":1},"char":{"name":"R2-D2","aspect":0.855,"bands":[["#bcc8d8",0.0085],["#737eaf",0.0684],["#b0b8c8",0.0427],["#3e3d7d",0.0855],["#cec4cb",0.0171],["#9b0c1d",0.0171],["#aeb5bd",0.0513],["#e6e9f8",0.0171],["#35345a",0.0171],["#7a7a8d",0.0598],["#e2e2e0",0.4957]],"accepted":["r2d2","r2-d2","r2 d2","r2","artoo","artoo detoo","r2d2 star wars","star wars r2d2"]}},{"week":4,"term":1,"weekInTerm":4,"focus":"virtuesOverview","plan":["gk","gk","gk","virtue","gk","teen","gk","gk","gk","char"],"virtueQ":{"q":"Character strengths are best described as —","choices":["positive traits and characteristics that help people think, feel and behave in ways that support themselves and others","school subjects everyone must pass","rules for after-school detention","positions on a sports team"],"a":0},"rebus":{"clue":"<span class=\"word long\">123strength456</span>","answer":"Strength in numbers","accepted":["strength in numbers","strength in number","strength in the numbers"]},"gk":[{"q":"Which country consumes the most coffee per person, according to common rankings?","choices":["Brazil","Finland","Italy","Colombia"],"a":1},{"q":"Which wall, built in 1961, divided Berlin until 1989?","choices":["The Berlin Wall","The Great Wall of China","Hadrian's Wall","The Atlantic Wall"],"a":0},{"q":"Which of these is a noble gas, mostly unreactive with other elements?","choices":["Chlorine","Nitrogen","Neon","Hydrogen"],"a":2},{"q":"In the Fibonacci sequence 1, 1, 2, 3, 5, 8, what number comes next?","choices":["10","11","13","15"],"a":2},{"q":"What is the term for the boundary between fresh river water and salty ocean water?","choices":["A delta","An estuary","A lagoon","A fjord"],"a":1},{"q":"Which Australian city hosted the 2000 Summer Olympic Games?","choices":["Melbourne","Brisbane","Sydney","Perth"],"a":2},{"q":"Which art movement, led by artists like Monet and Renoir, focused on capturing light and fleeting moments?","choices":["Cubism","Impressionism","Surrealism","Baroque"],"a":1}],"challenge":null,"music":null,"bonus":null,"teen":{"label":"Music","q":"Which Australian singer-songwriter is known for the hit song 'Riptide'?","choices":["Flume","Tame Impala","Vance Joy","Troye Sivan"],"a":2},"char":{"name":"The Hulk","aspect":0.54,"bands":[["#b5b1b2",0.0053],["#020101",0.0794],["#29b74c",0.5079],["#350f55",0.1429],["#29b74c",0.2169]],"accepted":["hulk","the hulk","incredible hulk","the incredible hulk","bruce banner","dr bruce banner","banner"]}},{"week":5,"term":1,"weekInTerm":5,"focus":"humanityIntro","plan":["teen","gk","rebus","char","gk","virtue","music","gk","gk","gk"],"virtueQ":{"q":"Which virtue groups together the strengths Love, Kindness, Social Intelligence?","choices":["Wisdom","Humanity","Justice","Courage"],"a":1},"rebus":{"clue":"<span class=\"word\">ri poorch</span>","answer":"Take from the rich and give to the poor","accepted":["take from the rich and give to the poor","take from the rich give to the poor","rob the rich give to the poor","rob from the rich and give to the poor","take from the rich","poor in rich"]},"gk":[{"q":"Which African country was formerly known as Abyssinia?","choices":["Egypt","Ethiopia","Sudan","Kenya"],"a":1},{"q":"Which 20th-century conflict is often dated from 1939 to 1945?","choices":["World War I","World War II","The Korean War","The Cold War"],"a":1},{"q":"Which scientist developed the theory of general relativity?","choices":["Isaac Newton","Niels Bohr","Albert Einstein","Stephen Hawking"],"a":2},{"q":"What is the pH value of a neutral solution, like pure water?","choices":["0","7","10","14"],"a":1},{"q":"What do you call the maximum population of a species that an environment can sustainably support?","choices":["The population density","The carrying capacity","The growth rate","The biomass limit"],"a":1}],"challenge":null,"music":{"notes":[["E4",1],["E4",1],["F4",1],["G4",1],["G4",1],["F4",1],["E4",1],["D4",1],["C4",1]],"tempoMs":420,"choices":["Mary Had a Little Lamb","Row Row Row Your Boat","Ode to Joy","Hot Cross Buns"],"a":2},"bonus":null,"teen":{"label":"School subjects","q":"What is the next prime number after 7?","choices":["9","10","13","11"],"a":3},"char":{"name":"Mickey Mouse","aspect":0.516,"bands":[["#727272",0.0062],["#010100",0.087],["#f5d7b7",0.1801],["#000000",0.1988],["#ed1c15",0.0311],["#fff7ee",0.0124],["#f61810",0.1056],["#010001",0.1242],["#f7d036",0.0124],["#f9c00e",0.1242],["#fffede",0.0124]],"accepted":["mickey mouse","mickey","mickey the mouse","mickie mouse"]}},{"week":6,"term":1,"weekInTerm":6,"focus":"love","plan":["gk","gk","virtue","gk","char","gk","rebus","gk","teen","gk"],"virtueQ":{"q":"Which VIA character strength is being described? \"The people closest to you are central to how you live, not an accessory to it. You invest in those relationships openly.\"","choices":["Kindness","Social Intelligence","Creativity","Love"],"a":3},"rebus":{"clue":"<span class=\"sightgrid\"><span class=\"word\">Love</span><span class=\"word\">sight</span><span></span><span class=\"word\">sight</span><span></span><span class=\"word\">sight</span></span>","answer":"Love at first sight","accepted":["love at first sight","love at first site","love at 1st sight"]},"gk":[{"q":"Which of these best describes a peninsula?","choices":["Land completely surrounded by water","Land almost surrounded by water, connected by a narrow strip","A large area of low, flat land","A ridge of underwater mountains"],"a":1},{"q":"In which year did the Australian colonies federate to become a nation?","choices":["1888","1901","1915","1927"],"a":1},{"q":"What is the SI (scientific) unit of electric current?","choices":["Volt","Watt","Ohm","Ampere"],"a":3},{"q":"What do you call two angles that add up to 90 degrees?","choices":["Supplementary angles","Complementary angles","Vertical angles","Alternate angles"],"a":1},{"q":"Which Nintendo character is a plumber who sets out to rescue Princess Peach?","choices":["Mario","Link","Kirby","Pikachu"],"a":0},{"q":"What is the term for a species so critical to its ecosystem that its removal would cause dramatic change?","choices":["An indicator species","A keystone species","An invasive species","An endemic species"],"a":1}],"challenge":null,"music":null,"bonus":null,"teen":{"label":"Sport","q":"Which Australian swimmer, nicknamed 'The Terminator', won the 400 m freestyle at the 2024 Paris Olympics?","choices":["Emma McKeon","Mollie O'Callaghan","Cate Campbell","Ariarne Titmus"],"a":3},"char":{"name":"Buzz Lightyear","aspect":0.529,"bands":[["#e0d3da",0.0096],["#8f797e",0.0192],["#fcceb8",0.2115],["#a7cf4c",0.1154],["#e7ebee",0.1154],["#010202",0.1058],["#afd15c",0.0192],["#e6eaec",0.2212],["#a7c664",0.0192]],"accepted":["buzz lightyear","buzz","buzz light year","buzz lightyear toy story","buzz from toy story"]}},{"week":7,"term":1,"weekInTerm":7,"focus":"social","plan":["gk","rebus","gk","gk","virtue","gk","gk","gk","gk","teen"],"virtueQ":{"q":"Which VIA character strength is being described? \"You read rooms well. Shifts in mood, unspoken tension, what someone actually means — you pick these up quickly.\"","choices":["Kindness","Creativity","Social Intelligence","Love"],"a":2},"rebus":{"clue":"<span class=\"stack\"><span class=\"hrule\"></span><span class=\"word\">READ</span><span class=\"hrule\"></span></span>","answer":"Read between the lines","accepted":["read between the lines","reading between the lines","read in between the lines","read between lines","reading between lines"]},"gk":[{"q":"Which two colours appear on the flag of Poland?","choices":["Red and white","Blue and yellow","Green and white","Black and gold"],"a":0},{"q":"Which author wrote the dystopian novel '1984'?","choices":["Aldous Huxley","Ray Bradbury","George Orwell","H.G. Wells"],"a":2},{"q":"What biological process transforms a caterpillar into an adult butterfly?","choices":["Metamorphosis","Germination","Photosynthesis","Fermentation"],"a":0},{"q":"Which is closer to the Sun on average: Earth or Mars?","choices":["Earth","Mars","They are the same distance","Neither orbits the Sun"],"a":0},{"q":"What is the name for the imaginary line that Earth spins around?","choices":["The equator","The axis","The meridian","The horizon"],"a":1},{"q":"Which chess piece can only move diagonally across the board?","choices":["The rook","The bishop","The knight","The pawn"],"a":1},{"q":"Which of these composers was deaf for much of his later career yet continued to compose?","choices":["Mozart","Beethoven","Bach","Chopin"],"a":1}],"challenge":null,"music":null,"bonus":null,"teen":{"label":"School subjects","q":"What is the chemical symbol for the element sodium?","choices":["Na","So","Sd","S"],"a":0}},{"week":8,"term":1,"weekInTerm":8,"focus":"kindness","plan":["gk","teen","gk","gk","rebus","char","virtue","gk","gk","gk"],"virtueQ":{"q":"Which VIA character strength is being described? \"Helping is your default setting. You notice what others need, often before they ask.\"","choices":["Love","Creativity","Kindness","Social Intelligence"],"a":2},"rebus":{"clue":"<span class=\"word\">MPARDE</span>","answer":"Pardon me","accepted":["pardon me","pardon","excuse me","beg your pardon"]},"gk":[{"q":"Which continent has the most countries?","choices":["Asia","Europe","Africa","South America"],"a":2},{"q":"In which year did the Eureka Stockade rebellion take place, on the Victorian goldfields?","choices":["1834","1854","1874","1901"],"a":1},{"q":"Which of these best defines a 'renewable' energy source?","choices":["One that is naturally replenished on human timescales","One that produces no waste at all","One that is always cheaper than fossil fuels","One found only underground"],"a":0},{"q":"What do you call the point in a planet's orbit when it is closest to the Sun?","choices":["Aphelion","Perihelion","Apogee","Zenith"],"a":1},{"q":"Which layer of Earth lies beneath the crust and is mostly solid rock that can flow very slowly over geological time?","choices":["The mantle","The outer core","The inner core","The crust"],"a":0},{"q":"Which of these is an example of onomatopoeia?","choices":["Buzz","Quick","Happy","Slowly"],"a":0}],"challenge":null,"music":null,"bonus":null,"teen":{"label":"TV & movies","q":"In the Harry Potter books, which Hogwarts house is Harry sorted into?","choices":["Slytherin","Gryffindor","Hufflepuff","Ravenclaw"],"a":1},"char":{"name":"Batman","aspect":0.522,"bands":[["#dbf2fc",0.0054],["#093862",0.2174],["#e9bf93",0.0598],["#073459",0.0435],["#a3a1af",0.2609],["#dbb97c",0.0326],["#08395f",0.0435],["#a2a2ad",0.125],["#093963",0.1467]],"accepted":["batman","the batman","bruce wayne","dark knight","the dark knight","bat man"]}},{"week":9,"term":1,"weekInTerm":9,"focus":"transcendIntro","plan":["char","gk","gk","gk","gk","teen","gk","music","virtue","gk"],"virtueQ":{"q":"Which virtue groups together the strengths Appreciation of Beauty, Gratitude, Hope, Humour, Spirituality?","choices":["Courage","Transcendence","Humanity","Wisdom"],"a":1},"rebus":{"clue":"<span class=\"word\"><span class=\"sensegrid\"><span>sense</span><span>sense</span><span>sense</span><span>sense</span><span>sense</span><span class=\"circled\">sense</span></span></span>","answer":"Sixth sense","accepted":["sixth sense","6th sense","a sixth sense","the sixth sense"]},"gk":[{"q":"What is the term for a country that has no access to the sea?","choices":["An island nation","A landlocked country","A peninsula state","A continental state"],"a":1},{"q":"How many ships made up the First Fleet that sailed to Australia in 1787-88?","choices":["6","9","11","15"],"a":2},{"q":"What is the chemical formula for ordinary table salt?","choices":["NaCl","H2O","CO2","KCl"],"a":0},{"q":"What do you call a group of stars that appears to form a pattern or picture in the night sky?","choices":["A galaxy","A nebula","A constellation","A cluster"],"a":2},{"q":"What is the name of the Pacific Ocean climate pattern associated with unusually warm surface waters and major weather shifts?","choices":["La Niña","El Niño","The Humboldt Current","The Kuroshio Current"],"a":1},{"q":"What do you call two words that sound the same but have different spellings and meanings, like 'flour' and 'flower'?","choices":["Synonyms","Antonyms","Homophones","Homographs"],"a":2}],"challenge":null,"music":{"notes":[["E5",0.5],["D#5",0.5],["E5",0.5],["D#5",0.5],["E5",0.5],["B4",0.5]],"tempoMs":480,"choices":["Twinkle Twinkle Little Star","Jingle Bells","London Bridge Is Falling Down","Fur Elise"],"a":3},"bonus":null,"teen":{"label":"Sport","q":"How many points is a try worth in rugby league?","choices":["4","2","5","6"],"a":0},"char":{"name":"Donald Duck","aspect":0.677,"bands":[["#cceaf8",0.0063],["#1a77c5",0.019],["#1c3145",0.0127],["#fcfdf9",0.0633],["#de8d08",0.0506],["#fcfdfb",0.0506],["#ad1b09",0.0316],["#1b79cf",0.2152],["#fefefc",0.2278],["#e58c08",0.1709]],"accepted":["donald duck","donald","donald the duck"]}},{"week":10,"term":1,"weekInTerm":10,"focus":"humour","plan":["rebus","gk","teen","gk","gk","gk","gk","gk","char","virtue"],"virtueQ":{"q":"Which VIA character strength is being described? \"You find the light side and you share it. You can take the heaviness out of a room without taking the substance out of it.\"","choices":["Hope","Appreciation of Beauty","Gratitude","Humour"],"a":3},"rebus":{"clue":"<span class=\"stack\"><span><span class=\"word compact\">funny funny</span></span><span><span class=\"word compact\">word word</span></span><span><span class=\"word compact\">word word</span></span></span>","answer":"Too funny for words","accepted":["too funny for words","funny for words","too funny for word","too funny"]},"gk":[{"q":"What do you call the boundary line that separates two countries?","choices":["A coastline","A border","A perimeter","A frontier zone only"],"a":1},{"q":"Which vast empire was founded and ruled by Genghis Khan?","choices":["The Ottoman Empire","The Mongol Empire","The Persian Empire","The Roman Empire"],"a":1},{"q":"What is the SI unit of frequency?","choices":["Watt","Hertz","Joule","Newton"],"a":1},{"q":"Which gas in the stratosphere absorbs much of the Sun's harmful ultraviolet radiation?","choices":["Oxygen (O2)","Ozone (O3)","Nitrogen (N2)","Carbon dioxide (CO2)"],"a":1},{"q":"Which term describes two species that both benefit from living closely together?","choices":["Parasitism","Commensalism","Mutualism","Predation"],"a":2},{"q":"What do you call the repetition of a consonant sound at the start of nearby words, like 'Peter Piper picked'?","choices":["Assonance","Alliteration","Consonance","Rhyme"],"a":1}],"challenge":null,"music":null,"bonus":null,"teen":{"label":"Music","q":"Which K-pop group has the members RM, Jin, Suga, J-Hope, Jimin, V and Jung Kook?","choices":["BTS","BLACKPINK","Stray Kids","TWICE"],"a":0},"char":{"name":"Mike Wazowski","aspect":0.528,"bands":[["#a4d340",0.1509],["#fafded",0.0755],["#55c297",0.0189],["#000800",0.0189],["#5dbf98",0.0283],["#fafded",0.0849],["#a4d43e",0.5189]],"accepted":["mike wazowski","mike","wazowski","mike wazowsky","mike from monsters inc","mike monsters inc","mike wazowski monsters inc"]}},{"week":11,"term":2,"weekInTerm":1,"focus":"spirituality","plan":["virtue","teen","gk","gk","char","gk","rebus","gk","gk","gk"],"virtueQ":{"q":"Which VIA character strength is being described? \"Your life is organised around a sense of meaning that goes beyond the day-to-day.\"","choices":["Gratitude","Spirituality","Hope","Appreciation of Beauty"],"a":1},"rebus":{"clue":"<span class=\"word\">The w<span class=\"sup\">KING</span>oods</span>","answer":"Hiking in the woods","accepted":["hiking in the woods","hiking in woods","hike in the woods","hiking the woods","hiking through the woods"]},"gk":[{"q":"Which country's flag features a red maple leaf on a white background bordered by red?","choices":["United States","Canada","Austria","Peru"],"a":1},{"q":"Which explorer is credited with proving Australia was a single landmass by circumnavigating it?","choices":["James Cook","Matthew Flinders","Abel Tasman","William Dampier"],"a":1},{"q":"Which human organ produces insulin?","choices":["Liver","Kidney","Pancreas","Spleen"],"a":2},{"q":"Which planet has the shortest year (orbital period) in our solar system?","choices":["Earth","Venus","Mercury","Mars"],"a":2},{"q":"Which type of rock is formed under intense heat and pressure, changing its original structure?","choices":["Igneous rock","Sedimentary rock","Metamorphic rock","Mineral rock"],"a":2},{"q":"Which of these is a simile rather than a metaphor?","choices":["Time is money","Life is a journey","As brave as a lion","The world is a stage"],"a":2}],"challenge":null,"music":null,"bonus":{"kind":"countdown","numbers":[75,2,8,1,6,100],"target":923},"teen":{"label":"Music","q":"Which Billie Eilish collaborator, who is also her brother, co-writes and produces her music?","choices":["Finley","Fenwick","Flynn","Finneas"],"a":3},"char":{"name":"Elmo","aspect":0.761,"bands":[["#aeaeae",0.0746],["#000000",0.0224],["#fafbf7",0.0522],["#976d35",0.0149],["#f87816",0.0597],["#050004",0.0597],["#fa3237",0.5299]],"accepted":["elmo","elmo sesame street","tickle me elmo"]}},{"week":12,"term":2,"weekInTerm":2,"focus":"appreciation","plan":["gk","teen","gk","gk","virtue","gk","gk","rebus","gk","gk"],"virtueQ":{"q":"Which VIA character strength is being described? \"Quality stops you in your tracks — a striking sky, a piece of music, someone doing difficult work superbly.\"","choices":["Appreciation of Beauty","Humour","Gratitude","Hope"],"a":0},"rebus":{"clue":"<span class=\"word\">G</span><span>👀</span><span class=\"word\">D</span>","answer":"Good looking","accepted":["good looking","goodlooking","good-looking","good lookin"]},"gk":[{"q":"Which country is home to the Terracotta Army, buried with the first Emperor of China?","choices":["China","Japan","Vietnam","Mongolia"],"a":0},{"q":"Which British explorer charted the eastern coast of Australia in 1770?","choices":["Abel Tasman","James Cook","Matthew Flinders","William Dampier"],"a":1},{"q":"Which organelle is often called the 'powerhouse of the cell'?","choices":["Nucleus","Mitochondria","Ribosome","Golgi apparatus"],"a":1},{"q":"Which spacecraft was the first human-made object to enter interstellar space?","choices":["Voyager 1","Cassini","New Horizons","Pioneer 10"],"a":0},{"q":"Which country's revolution in 1789 led to the end of its monarchy and the rise of Napoleon?","choices":["Russia","France","Germany","Spain"],"a":1},{"q":"What do you call a word borrowed directly from another language with little or no change, like 'kindergarten'?","choices":["A synonym","A loanword","A homophone","An acronym"],"a":1},{"q":"Which fruit is the main ingredient in guacamole?","choices":["Lime","Mango","Avocado","Cucumber"],"a":2}],"challenge":null,"music":null,"bonus":null,"teen":{"label":"TV & movies","q":"Which Australian animated series follows a family of Blue Heeler dogs?","choices":["Peppa Pig","Paw Patrol","Bluey","Hey Duggee"],"a":2}},{"week":13,"term":2,"weekInTerm":3,"focus":"hope","plan":["music","gk","gk","gk","rebus","char","virtue","gk","teen","gk"],"virtueQ":{"q":"Which VIA character strength is being described? \"You treat the future as something to build, not something that happens to you. Your optimism comes with effort attached.\"","choices":["Appreciation of Beauty","Gratitude","Hope","Humour"],"a":2},"rebus":{"clue":"<span class=\"cross\"><span class=\"c1\"></span><span class=\"c2\">f</span><span class=\"c3\"></span><span class=\"c1\"></span><span class=\"c2\">i</span><span class=\"c3\"></span><span class=\"c1\"></span><span class=\"c2\">n</span><span class=\"c3\"></span><span class=\"c1\">fin</span><span class=\"c2\">g</span><span class=\"c3\">ers</span><span class=\"c1\"></span><span class=\"c2\">e</span><span class=\"c3\"></span><span class=\"c1\"></span><span class=\"c2\">r</span><span class=\"c3\"></span><span class=\"c1\"></span><span class=\"c2\">s</span><span class=\"c3\"></span></span>","answer":"Fingers crossed","accepted":["fingers crossed","finger crossed","crossed fingers","fingers are crossed","keep your fingers crossed"]},"gk":[{"q":"Which strait separates Russia from Alaska (the USA)?","choices":["Bering Strait","Bass Strait","Cook Strait","Torres Strait"],"a":0},{"q":"Which Australian Prime Minister disappeared while swimming in 1967 and was never found?","choices":["Robert Menzies","Harold Holt","John Gorton","William McMahon"],"a":1},{"q":"Which of these has the shortest wavelength on the electromagnetic spectrum?","choices":["Radio waves","Visible light","Gamma rays","Microwaves"],"a":2},{"q":"What is the name of the reusable spacecraft program run by NASA from 1981 to 2011?","choices":["Apollo program","Gemini program","Space Shuttle program","Skylab program"],"a":2},{"q":"What do you call an argument with a flaw in its reasoning that makes it invalid, even if it sounds convincing?","choices":["A hypothesis","A logical fallacy","A theorem","A paradox"],"a":1}],"challenge":null,"music":{"notes":[["G4",0.5],["G4",0.5],["G4",0.5],["Eb4",2],["F4",0.5]],"tempoMs":190,"choices":["Old MacDonald Had a Farm","Row Row Row Your Boat","Beethoven's Symphony No. 5","Mary Had a Little Lamb"],"a":2},"bonus":null,"teen":{"label":"School subjects","q":"Which figure of speech says something IS something else, as in 'The classroom was a zoo'?","choices":["A simile","A metaphor","Personification","Hyperbole"],"a":1},"char":{"name":"Genie","aspect":0.543,"bands":[["#83726a",0.0095],["#97b3cb",0.019],["#65b4f3",0.1619],["#2c3748",0.019],["#66b4f2",0.3238],["#c10716",0.1048],["#3478ab",0.2857]],"accepted":["genie","the genie","aladdin's genie","aladdin genie","genie from aladdin","blue genie","genie aladdin"]}},{"week":14,"term":2,"weekInTerm":4,"focus":"gratitude","plan":["gk","virtue","char","gk","gk","teen","gk","gk","gk","gk"],"virtueQ":{"q":"Which VIA character strength is being described? \"You keep track of the good in your life rather than taking it as given, and you make sure people know what they've meant to you.\"","choices":["Hope","Appreciation of Beauty","Humour","Gratitude"],"a":3},"rebus":{"clue":"<span class=\"stack\"><span><span class=\"word compact\">thanks thanks</span></span><span><span class=\"word compact\">thanks thanks</span></span><span><span class=\"word compact\">thanks thanks</span></span><span><span class=\"word compact\">thanks thanks</span></span><span><span class=\"word compact\">thanks thanks</span></span></span>","answer":"Many thanks","accepted":["many thanks","thanks a lot","thanks lots","lots of thanks","thanks a million","many many thanks"]},"gk":[{"q":"Which Queensland region is famous for growing sugar cane along the coast?","choices":["The Darling Downs","The Channel Country","Far North Queensland's coastal belt","The Western Downs"],"a":2},{"q":"Which ancient Egyptian writing system used pictures to represent words and sounds?","choices":["Cuneiform","Hieroglyphics","Sanskrit script","Phoenician script"],"a":1},{"q":"What do you call farming practised without synthetic fertilisers or pesticides?","choices":["Organic farming","Hydroponics","Aquaculture","Subsistence farming"],"a":0},{"q":"What is the name of the force that keeps planets in orbit around the Sun?","choices":["Magnetism","Gravity","Friction","Inertia"],"a":1},{"q":"What do you call money paid to the government based on income or purchases?","choices":["Interest","Tax","Dividend","Rent"],"a":1},{"q":"What is the longest bone in the human body?","choices":["Femur","Humerus","Tibia","Spine"],"a":0},{"q":"Which sculptor created the famous marble statue of 'David'?","choices":["Leonardo da Vinci","Donatello","Michelangelo","Bernini"],"a":2}],"challenge":null,"music":null,"bonus":null,"teen":{"label":"School subjects","q":"Which document, signed in 1215, limited the power of the English king?","choices":["The Domesday Book","The Bill of Rights","The Magna Carta","The Declaration of Independence"],"a":2},"char":{"name":"Jasmine","aspect":0.543,"bands":[["#becbd3",0.0095],["#1a2f3f",0.0762],["#fbb274",0.219],["#8dd1cf",0.1429],["#f9af7a",0.1143],["#8fd1cd",0.3143],["#d2b897",0.019],["#92cdc9",0.0286]],"accepted":["jasmine","princess jasmine","jasmin","jasmine aladdin","aladdin's jasmine"]}},{"week":15,"term":2,"weekInTerm":5,"focus":"wisdomIntro","plan":["gk","rebus","gk","gk","gk","virtue","gk","teen","gk","char"],"virtueQ":{"q":"Which virtue groups together the strengths Creativity, Curiosity, Judgement, Love of Learning, Perspective?","choices":["Wisdom","Courage","Humanity","Justice"],"a":0},"rebus":{"clue":"<span class=\"word grey\">Matter</span>","answer":"Grey matter","accepted":["grey matter","gray matter","grey matters"]},"gk":[{"q":"What is the traditional name for the sacred rock formation known in English as Ayers Rock?","choices":["Kata Tjuta","Uluru","Karlu Karlu","Kakadu"],"a":1},{"q":"Which former British colony became independent in 1947, later splitting into two countries that same year?","choices":["Kenya","India (and Pakistan)","Nigeria","Malaysia"],"a":1},{"q":"What is the process called when a liquid changes directly into a gas at its surface, below boiling point?","choices":["Sublimation","Evaporation","Condensation","Precipitation"],"a":1},{"q":"What do you call a meteor that survives its fall through the atmosphere and lands on Earth?","choices":["A comet","A meteorite","An asteroid","A satellite"],"a":1},{"q":"What do you call a leader who rules a country with absolute power, often seizing control by force?","choices":["A monarch","A dictator","A president","A governor"],"a":1},{"q":"Which language family does English belong to?","choices":["Romance","Germanic","Slavic","Celtic"],"a":1}],"challenge":null,"music":null,"bonus":null,"teen":{"label":"Sport","q":"Which sport uses the scoring terms 'love', 'deuce' and 'advantage'?","choices":["Golf","Tennis","Cricket","Netball"],"a":1},"char":{"name":"Pinocchio","aspect":0.547,"bands":[["#fffee3",0.0189],["#836a28",0.066],["#070000",0.0189],["#fbc693",0.1509],["#1198d1",0.0283],["#fee18d",0.1887],["#d50300",0.217],["#fcc691",0.1321],["#8f120e",0.066]],"accepted":["pinocchio","pinochio","pinnochio","pinocchio the puppet","pinoccio"]}},{"week":16,"term":2,"weekInTerm":6,"focus":"learning","plan":["char","virtue","rebus","gk","teen","gk","gk","gk","gk","gk"],"virtueQ":{"q":"Which VIA character strength is being described? \"Adding to what you know is genuinely satisfying, whether or not anyone is grading it. You build skills and knowledge for their own sake.\"","choices":["Creativity","Love of Learning","Curiosity","Judgement"],"a":1},"rebus":{"clue":"<span class=\"sumgrid\"><span></span><span>M</span><span>a</span><span>r</span><span>y</span><span>+</span><span>M</span><span>a</span><span>r</span><span>y</span><span>+</span><span>M</span><span>a</span><span>r</span><span>y</span><span class=\"rule\"></span></span>","answer":"Summary","accepted":["summary","sum mary","sum marry","sum mery"]},"gk":[{"q":"Which country's flag is a simple design of a red circle on a white background?","choices":["China","South Korea","Japan","Vietnam"],"a":2},{"q":"Roughly when did the Renaissance begin in Europe?","choices":["9th century","14th century","18th century","20th century"],"a":1},{"q":"What is the term for the smallest unit of heredity, carried on chromosomes?","choices":["A cell","A gene","An enzyme","A protein"],"a":1},{"q":"Which spacecraft mission first landed humans on the Moon, in 1969?","choices":["Apollo 8","Apollo 11","Apollo 13","Gemini 4"],"a":1},{"q":"What is the term for the branch of government responsible for making laws?","choices":["The executive","The legislature","The judiciary","The bureaucracy"],"a":1},{"q":"What do you call a word that is spelled the same forwards and backwards, like 'level'?","choices":["An anagram","A palindrome","A homograph","An acrostic"],"a":1}],"challenge":null,"music":null,"bonus":null,"teen":{"label":"Music","q":"Which Australian rock band's lead guitarist, Angus Young, famously performs in a school uniform?","choices":["INXS","AC/DC","Midnight Oil","Cold Chisel"],"a":1},"char":{"name":"Pluto","aspect":0.552,"bands":[["#645d64",0.0095],["#0b0601",0.0381],["#f5b710",0.2286],["#23b44d",0.0286],["#f6b70d",0.619]],"accepted":["pluto","pluto the dog","pluto dog","mickey's dog","mickeys dog","disney pluto"]}},{"week":17,"term":2,"weekInTerm":7,"focus":"perspective","plan":["gk","gk","gk","virtue","gk","music","gk","rebus","teen","gk"],"virtueQ":{"q":"Which VIA character strength is being described? \"You tend to see how the pieces of a situation fit together, which is why people seek your take when things get complicated.\"","choices":["Judgement","Creativity","Curiosity","Perspective"],"a":3},"rebus":{"clue":"<span class=\"word\">Try</span><span class=\"frac\"><span>stand</span><span>2</span></span>","answer":"Try to understand","accepted":["try to understand","try and understand","trying to understand","try 2 understand"]},"gk":[{"q":"Which two rivers together defined ancient Mesopotamia, 'the land between rivers'?","choices":["The Nile and the Jordan","The Tigris and the Euphrates","The Indus and the Ganges","The Yangtze and the Yellow River"],"a":1},{"q":"Which Renaissance artist painted the ceiling of the Sistine Chapel?","choices":["Leonardo da Vinci","Michelangelo","Raphael","Donatello"],"a":1},{"q":"Which blood type is commonly called the 'universal donor' for red blood cell transfusions?","choices":["AB positive","O negative","A positive","B negative"],"a":1},{"q":"Which is the largest moon in our solar system, orbiting Jupiter?","choices":["Titan","Europa","Ganymede","Callisto"],"a":2},{"q":"Which country experienced the Meiji Restoration beginning in 1868, rapidly modernising its government and economy?","choices":["China","Korea","Japan","Thailand"],"a":2},{"q":"Which language has the most native speakers in the world?","choices":["English","Spanish","Mandarin Chinese","Hindi"],"a":2}],"challenge":null,"music":{"notes":[["E4",1],["E4",1],["E4",2],["E4",1],["E4",1],["E4",2],["E4",1]],"tempoMs":220,"choices":["Row Row Row Your Boat","Old MacDonald Had a Farm","Jingle Bells","Twinkle Twinkle Little Star"],"a":2},"bonus":null,"teen":{"label":"TV & movies","q":"Which Netflix series is set in the town of Hawkins, Indiana?","choices":["Wednesday","Outer Banks","Squid Game","Stranger Things"],"a":3}},{"week":18,"term":2,"weekInTerm":8,"focus":"curiosity","plan":["gk","rebus","virtue","gk","gk","char","gk","gk","gk","teen"],"virtueQ":{"q":"Which VIA character strength is being described? \"Unanswered questions bother you in the best way. New topics, places, and ideas pull you in, and you'd rather investigate something than leave it unexplained.\"","choices":["Judgement","Curiosity","Love of Learning","Creativity"],"a":1},"rebus":{"clue":"<span class=\"word tiny\">scope</span>","answer":"Microscope","accepted":["microscope","micro scope","a microscope","tiny scope"]},"gk":[{"q":"Which continent is almost entirely covered by a permanent ice sheet?","choices":["Greenland","Antarctica","Australia","Africa"],"a":1},{"q":"In which decade did the Great Depression begin?","choices":["1900s","1920s","1930s","1950s"],"a":1},{"q":"Which gas makes up roughly 78% of Earth's atmosphere?","choices":["Oxygen","Nitrogen","Carbon dioxide","Argon"],"a":1},{"q":"Which planet in our solar system has a day that is longer than its year?","choices":["Mercury","Venus","Mars","Neptune"],"a":1},{"q":"In the Australian federal system, which house of parliament is often called the 'house of review'?","choices":["The House of Representatives","The Senate","The Governor-General's office","The High Court"],"a":1},{"q":"What is a group of lions called?","choices":["A pack","A pride","A herd","A flock"],"a":1}],"challenge":null,"music":null,"bonus":null,"teen":{"label":"Sport","q":"In basketball, what is it called when a player takes too many steps without dribbling?","choices":["Fouling","Goaltending","Travelling","Charging"],"a":2},"char":{"name":"Goofy","aspect":0.528,"bands":[["#cde96d",0.1321],["#0c0a00",0.0283],["#fcc994",0.1132],["#fa9929",0.2736],["#0a60a9",0.2547],["#cb630c",0.0755]],"accepted":["goofy","goofy dog","goofy goof"]}},{"week":19,"term":2,"weekInTerm":9,"focus":"creativity","plan":["char","gk","gk","gk","gk","teen","virtue","gk","gk","gk"],"virtueQ":{"q":"Which VIA character strength is being described? \"Coming up with ideas is your natural mode. When something isn't working, your instinct is to invent a different route rather than push harder down the existing one.\"","choices":["Creativity","Love of Learning","Curiosity","Judgement"],"a":0},"rebus":{"clue":"<span class=\"word tilt\">musically</span>","answer":"Musically inclined","accepted":["musically inclined","musical inclined","musically incline"]},"gk":[{"q":"Which two countries share the longest international land border in the world?","choices":["USA and Canada","Russia and China","India and China","Brazil and Argentina"],"a":0},{"q":"Which 1929 event is widely regarded as a major turning point in the onset of the Great Depression?","choices":["A World War","The Wall Street Crash (stock market crash)","A drought","A banking law change"],"a":1},{"q":"What do you call the study of how heat and energy are transferred and transformed?","choices":["Thermodynamics","Electromagnetism","Mechanics","Optics"],"a":0},{"q":"Roughly how long does it take light from the Sun to reach Earth?","choices":["8 seconds","8 minutes","8 hours","8 days"],"a":1},{"q":"Which system of government has a hereditary monarch as head of state whose powers are limited by a constitution and laws?","choices":["A republic","A constitutional monarchy","An absolute monarchy","A theocracy"],"a":1},{"q":"What do you call a word blended from two other words, like 'brunch' from 'breakfast' and 'lunch'?","choices":["An acronym","A portmanteau","A homophone","A neologism only"],"a":1},{"q":"What is the term for a piece of music played by a single performer, without accompaniment?","choices":["A duet","A solo","An ensemble","A chorus"],"a":1}],"challenge":null,"music":null,"bonus":{"kind":"countdown","numbers":[100,7,3,25,4,4],"target":323},"teen":{"label":"School subjects","q":"Which ocean lies between Australia and Africa?","choices":["Atlantic Ocean","Pacific Ocean","Southern Ocean","Indian Ocean"],"a":3},"char":{"name":"Princess Aurora","aspect":0.519,"bands":[["#fffee1",0.0189],["#f9ae31",0.0849],["#fdceb6",0.1698],["#ffeee7",0.0189],["#faa6c8",0.0283],["#d63b79",0.217],["#fca0c9",0.0377],["#f07fb1",0.3302],["#ffe4fa",0.0189],["#e789ae",0.0377]],"accepted":["aurora","princess aurora","sleeping beauty","princess sleeping beauty","briar rose","aurora sleeping beauty"]}},{"week":20,"term":2,"weekInTerm":10,"focus":"judgement","plan":["gk","char","gk","gk","rebus","gk","gk","teen","virtue","gk"],"virtueQ":{"q":"Which VIA character strength is being described? \"You weigh things up before you commit to a view. Evidence matters more to you than first impressions, and being shown you were wrong feels useful rather than threatening.\"","choices":["Creativity","Curiosity","Judgement","Love of Learning"],"a":2},"rebus":{"clue":"<span class=\"stack\"><span><span class=\"word compact\">choice</span></span><span><span class=\"word compact\">choice</span></span><span><span class=\"word compact\">choice</span></span><span><span class=\"word compact\">choice</span></span></span>","answer":"Multiple choice","accepted":["multiple choice","multiple choices","many choice","many choices"]},"gk":[{"q":"Which desert is the largest hot desert in the world?","choices":["Gobi Desert","Kalahari Desert","Sahara Desert","Arabian Desert"],"a":2},{"q":"What was the name of the trade route connecting China with the Mediterranean world?","choices":["The Amber Road","The Silk Road","The Incense Route","The Spice Route"],"a":1},{"q":"What is the term for a substance that speeds up a chemical reaction without being used up?","choices":["A reactant","A catalyst","A solvent","An isotope"],"a":1},{"q":"Which force is responsible for the tides on Earth's oceans?","choices":["Wind","The Moon's (and Sun's) gravity","Earth's rotation alone","Ocean currents"],"a":1},{"q":"Which type of economy relies on supply and demand with minimal government control, in its purest theoretical form?","choices":["A command economy","A free market economy","A mixed economy","A subsistence economy"],"a":1},{"q":"What do you call a group of words that has a subject and a verb, expresses a complete thought and can stand alone as a sentence?","choices":["A phrase","A fragment","An independent clause (a complete sentence)","A dependent clause"],"a":2}],"challenge":null,"music":null,"bonus":null,"teen":{"label":"Music","q":"Which music streaming service releases an end-of-year summary called 'Wrapped'?","choices":["Apple Music","YouTube Music","Spotify","SoundCloud"],"a":2},"char":{"name":"The Beast","aspect":0.528,"bands":[["#a46f11",0.2925],["#fcdc18",0.0377],["#333fd1",0.2925],["#010002",0.217],["#a06f18",0.066]],"accepted":["beast","the beast","beast from beauty and the beast","prince adam","adam the beast","beauty and the beast beast"]}},{"week":21,"term":3,"weekInTerm":1,"focus":"virtuesRecap","plan":["gk","gk","gk","rebus","teen","gk","music","gk","char","virtue"],"virtueQ":{"q":"Which virtue groups Love, Kindness and Social Intelligence?","choices":["Wisdom","Humanity","Justice","Temperance"],"a":1},"rebus":{"clue":"<span class=\"word histo\">historyhistoryhistory</span>","answer":"History repeats itself","accepted":["history repeats itself","history repeating itself","history repeats","history repeat itself"]},"gk":[{"q":"Which country has the largest population in the world, as of recent estimates?","choices":["China","India","United States","Indonesia"],"a":1},{"q":"In which year did the First Fleet arrive in Australia?","choices":["1770","1788","1801","1850"],"a":1},{"q":"What do you call the total distance around the outside of a shape?","choices":["The area","The perimeter","The diameter","The volume"],"a":1},{"q":"Which planet has a prominent set of rings made mostly of ice and rock, visible even from small telescopes?","choices":["Jupiter","Saturn","Uranus","Mars"],"a":1},{"q":"What is the name of Australia's parliament house city, purpose-built as the national capital?","choices":["Sydney","Melbourne","Canberra","Darwin"],"a":2}],"challenge":null,"music":{"notes":[["E4",1],["D4",1],["C4",1],["D4",1],["E4",1],["E4",1],["E4",2],["D4",1]],"tempoMs":420,"choices":["Mary Had a Little Lamb","Fur Elise","Hot Cross Buns","Ode to Joy"],"a":0},"bonus":null,"teen":{"label":"TV & movies","q":"In The Lord of the Rings, in which volcano must the One Ring be destroyed?","choices":["Mount Doom","Mount Fuji","Mount Vesuvius","Mount Olympus"],"a":0},"char":{"name":"Wonder Woman","aspect":0.559,"bands":[["#dcdcdc",0.0053],["#101012",0.0798],["#f2e63e",0.016],["#eebe90",0.2234],["#cf3e37",0.1596],["#c03f0c",0.0106],["#f1e606",0.0798],["#177ab5",0.0532],["#f0be8f",0.1117],["#ec0915",0.1489]],"accepted":["wonder woman","wonderwoman","diana","diana prince","princess diana of themyscira"]}},{"week":22,"term":3,"weekInTerm":2,"focus":"permahRecap","plan":["virtue","gk","rebus","teen","gk","gk","gk","gk","gk","gk"],"virtueQ":{"q":"In PERMAH, what does the 'E' stand for?","choices":["Effort","Engagement","Energy","Excellence"],"a":1},"rebus":{"clue":"<span class=\"word small\">another</span><span class=\"gap\"></span><span class=\"word small\">one thing</span>","answer":"One thing after another","accepted":["one thing after another","one thing after the other","one thing after an other"]},"gk":[{"q":"Which sea is famous for being so salty that swimmers float very easily?","choices":["The Red Sea","The Dead Sea","The Black Sea","The Caspian Sea"],"a":1},{"q":"What was the Eastern Roman Empire, which survived for nearly 1,000 years after the fall of Rome, commonly called?","choices":["The Holy Roman Empire","The Byzantine Empire","The Ottoman Empire","The Frankish Empire"],"a":1},{"q":"What do you call a number raised to the third power, such as 2 × 2 × 2?","choices":["A square number","A cube number","A prime number","A composite number"],"a":1},{"q":"Which country launched the first artificial satellite, Sputnik 1, in 1957?","choices":["United States","Soviet Union","United Kingdom","China"],"a":1},{"q":"Which country was the first self-governing country to grant women the right to vote in national elections?","choices":["United Kingdom","United States","New Zealand","Australia"],"a":2},{"q":"Which figure of speech gives human qualities to non-human things, like 'the wind whispered'?","choices":["Simile","Metaphor","Personification","Alliteration"],"a":2},{"q":"Which composer wrote 'The Four Seasons', a set of violin concertos?","choices":["Johann Sebastian Bach","Antonio Vivaldi","Wolfgang Amadeus Mozart","Frederic Chopin"],"a":1}],"challenge":null,"music":null,"bonus":null,"teen":{"label":"School subjects","q":"Which nutrient is the body's main source of energy?","choices":["Protein","Carbohydrates","Vitamins","Fibre"],"a":1}},{"week":23,"term":3,"weekInTerm":3,"focus":"justiceIntro","plan":["gk","teen","gk","gk","gk","gk","char","virtue","gk","rebus"],"virtueQ":{"q":"Which virtue groups together the strengths Teamwork, Fairness, Leadership?","choices":["Justice","Courage","Humanity","Wisdom"],"a":0},"rebus":{"clue":"<span class=\"stack\"><span><span class=\"word\">ILL</span></span><span><span>🦅</span></span></span>","answer":"Illegal","accepted":["illegal","ill eagle","ill eagal","unlawful"]},"gk":[{"q":"Which country is the world's largest by land area?","choices":["Canada","China","United States","Russia"],"a":3},{"q":"What do you call the period of tension between the United States and the Soviet Union after World War II, without direct large-scale conflict?","choices":["World War III","The Cold War","The Iron Curtain Crisis","The Space Race"],"a":1},{"q":"If a triangle has a base of 10 cm and a height of 6 cm, what is its area?","choices":["16 cm²","30 cm²","60 cm²","36 cm²"],"a":1},{"q":"What is the collective name for the belt of small rocky objects between Mars and Jupiter?","choices":["The Kuiper Belt","The Asteroid Belt","The Oort Cloud","The Van Allen Belt"],"a":1},{"q":"What is the term for the total value of goods and services a country produces in a year?","choices":["Gross Domestic Product (GDP)","Consumer Price Index (CPI)","Trade Balance","National Debt"],"a":0},{"q":"In grammar, what part of speech describes or modifies a noun?","choices":["A verb","An adjective","An adverb","A conjunction"],"a":1}],"challenge":null,"music":null,"bonus":null,"teen":{"label":"Sport","q":"How many players does one soccer team have on the field, including the goalkeeper?","choices":["9","10","12","11"],"a":3},"char":{"name":"Winnie the Pooh","aspect":0.528,"bands":[["#ffffd6",0.0094],["#fed915",0.2925],["#ee493a",0.2453],["#fed916",0.3868]],"accepted":["winnie the pooh","pooh","pooh bear","winnie pooh","winnie","winnie-the-pooh","winnie the poo","pooh the bear"]}},{"week":24,"term":3,"weekInTerm":4,"focus":"leadership","plan":["gk","char","gk","gk","gk","gk","virtue","gk","teen","gk"],"virtueQ":{"q":"Which VIA character strength is being described? \"When a group needs direction, you're willing to provide it — and you make sure nobody gets left on the outside while it happens.\"","choices":["Creativity","Fairness","Teamwork","Leadership"],"a":3},"rebus":{"clue":"<span class=\"word mono\">yourballcourt</span>","answer":"The ball is in your court","accepted":["the ball is in your court","ball is in your court","ball in your court","your ball court","the ball is in my court"]},"gk":[{"q":"Which country uses the rupee as its currency?","choices":["Thailand","India","Vietnam","Malaysia"],"a":1},{"q":"Which explorer's expedition was the first to circumnavigate the globe, though he died before it was completed?","choices":["Christopher Columbus","Vasco da Gama","Ferdinand Magellan","James Cook"],"a":2},{"q":"Which Australian marsupial sleeps for up to 20 hours a day and eats eucalyptus leaves?","choices":["Koala","Wombat","Quokka","Tasmanian devil"],"a":0},{"q":"Which number greater than 1 is both a perfect square and a perfect cube?","choices":["8","16","64","81"],"a":2},{"q":"What do we call the layer of the Sun that we can see, which gives off most of its visible light?","choices":["The corona","The photosphere","The chromosphere","The core"],"a":1},{"q":"Which term describes a rise in the general price level of goods and services over time?","choices":["Deflation","Inflation","Recession","Stagnation"],"a":1},{"q":"What do you call a word made by combining the first letters of a phrase, pronounced as a word, like 'laser'?","choices":["An acronym","An abbreviation","A contraction","A portmanteau"],"a":0}],"challenge":null,"music":null,"bonus":null,"teen":{"label":"School subjects","q":"In computing, what does 'CPU' stand for?","choices":["Central Processing Unit","Computer Personal Unit","Central Program Utility","Core Power Unit"],"a":0},"char":{"name":"Piglet","aspect":0.795,"bands":[["#e1898f",0.0787],["#fbd1cb",0.2047],["#a11142",0.0157],["#5c0723",0.2047],["#640528",0.1339],["#f9d2cb",0.2205]],"accepted":["piglet","piglet from winnie the pooh","pooh's friend piglet","pigglet"]}},{"week":25,"term":3,"weekInTerm":5,"focus":"fairness","plan":["gk","teen","music","gk","gk","virtue","gk","char","rebus","gk"],"virtueQ":{"q":"Which VIA character strength is being described? \"Even-handedness matters to you on principle. You apply the same standards to people you like and people you don't.\"","choices":["Leadership","Fairness","Creativity","Teamwork"],"a":1},"rebus":{"clue":"<span class=\"word\">HO<span class=\"lc\">rob</span>OD</span>","answer":"Robin Hood","accepted":["robin hood","robinhood","rob in hood","robin in hood"]},"gk":[{"q":"Which African country is entirely surrounded by South Africa?","choices":["Eswatini","Lesotho","Botswana","Zimbabwe"],"a":1},{"q":"Who was Australia's first female Prime Minister?","choices":["Quentin Bryce","Julia Gillard","Julie Bishop","Bronwyn Bishop"],"a":1},{"q":"What is the median of the numbers 3, 7, 9, 15, 21?","choices":["7","9","15","12"],"a":1},{"q":"Which planet is often called Earth's 'twin' due to its similar size?","choices":["Mars","Venus","Mercury","Uranus"],"a":1},{"q":"What is the name of Australia's national government science agency?","choices":["CSIRO","NASA","NOAA","BOM"],"a":0}],"challenge":null,"music":{"notes":[["E4",1],["D4",1],["C4",2],["E4",1],["D4",1],["C4",2],["C4",0.5],["C4",0.5],["C4",0.5],["C4",0.5],["D4",0.5]],"tempoMs":480,"choices":["Row Row Row Your Boat","Hot Cross Buns","Jingle Bells","Happy Birthday"],"a":1},"bonus":null,"teen":{"label":"TV & movies","q":"Which Marvel hero's alter ego is Peter Parker?","choices":["Iron Man","Spider-Man","Batman","Ant-Man"],"a":1},"char":{"name":"Supergirl","aspect":0.473,"bands":[["#fffeda",0.0106],["#f1e605",0.1117],["#eebf8f",0.2074],["#1f6abb",0.2128],["#f6eb15",0.0213],["#d32929",0.0638],["#eebf92",0.1117],["#d42830",0.1543]],"accepted":["supergirl","super girl","kara","kara danvers","kara zor-el","kara zor el"]}},{"week":26,"term":3,"weekInTerm":6,"focus":"teamwork","plan":["gk","gk","rebus","virtue","teen","gk","gk","gk","gk","char"],"virtueQ":{"q":"Which VIA character strength is being described? \"When you're part of a group, the group's result becomes your result. People learn quickly that you can be counted on.\"","choices":["Teamwork","Creativity","Fairness","Leadership"],"a":0},"rebus":{"clue":"<span class=\"word\">Way go go</span>","answer":"Way to go","accepted":["way to go","way 2 go","way too go"]},"gk":[{"q":"Which European country was ruled by the Habsburg dynasty for centuries?","choices":["France","Austria","Sweden","Portugal"],"a":1},{"q":"Which Australian state was founded from the very start as a free colony, without convicts?","choices":["New South Wales","Tasmania","South Australia","Queensland"],"a":2},{"q":"What do you call a whole number greater than 1 that has no divisors other than 1 and itself?","choices":["A composite number","A prime number","An irrational number","A perfect number"],"a":1},{"q":"What is the name of the galaxy that contains our solar system?","choices":["Andromeda","Triangulum","The Milky Way","The Sombrero Galaxy"],"a":2},{"q":"What is the term for an election in which voters must, by law, cast a vote?","choices":["Optional voting","Compulsory voting","Preferential voting","Proxy voting"],"a":1},{"q":"In a story's structure, what do you call the moment of greatest tension, just before the resolution?","choices":["The exposition","The rising action","The climax","The denouement"],"a":2}],"challenge":null,"music":null,"bonus":null,"teen":{"label":"Music","q":"In music, what is the word for the speed of a piece, usually measured in beats per minute?","choices":["Pitch","Rhythm","Harmony","Tempo"],"a":3},"char":{"name":"Cheer Bear","aspect":0.55,"bands":[["#f9a89a",0.5],["#ffffff",0.05],["#d32f2f",0.02],["#f57c00",0.02],["#fbc02d",0.02],["#388e3c",0.02],["#1976d2",0.02],["#7b1fa2",0.02],["#ffffff",0.07],["#f9a89a",0.26]],"accepted":["cheer bear","cheerbear","care bear","care bears","cheer care bear","pink care bear"]}},{"week":27,"term":3,"weekInTerm":7,"focus":"courageIntro","plan":["virtue","rebus","teen","gk","gk","gk","gk","gk","gk","gk"],"virtueQ":{"q":"Which virtue groups together the strengths Bravery, Perseverance, Honesty, Zest?","choices":["Humanity","Justice","Courage","Wisdom"],"a":2},"rebus":{"clue":"<span class=\"nerves\"><span style=\"transform:rotate(-28deg)\">nerve</span><span style=\"transform:rotate(-14deg)\">nerve</span><span style=\"transform:rotate(0deg)\">nerve</span><span style=\"transform:rotate(14deg)\">nerve</span><span style=\"transform:rotate(28deg)\">nerve</span><span style=\"transform:rotate(-20deg)\">nerve</span><span style=\"transform:rotate(20deg)\">nerve</span></span>","answer":"A bundle of nerves","accepted":["a bundle of nerves","bundle of nerves","bunch of nerves","a bundle of nerve","bundle of nerve"]},"gk":[{"q":"Which ancient civilisation built the mountain city of Machu Picchu?","choices":["The Aztec","The Maya","The Inca","The Olmec"],"a":2},{"q":"Which Dutch explorer was the first European recorded to sight Tasmania and New Zealand?","choices":["Willem Janszoon","Abel Tasman","Dirk Hartog","Jan Carstenszoon"],"a":1},{"q":"What do you call the result of multiplying a number by itself?","choices":["A root","A square","A factor","A prime"],"a":1},{"q":"What is the term for a star that suddenly flares in brightness and then fades back, without being destroyed?","choices":["A supernova","A pulsar","A nova","A quasar"],"a":2},{"q":"What is the term for an extremely rapid and severe rise in prices?","choices":["Inflation","Hyperinflation","Deflation","Recession"],"a":1},{"q":"Which term describes a story told from a narrator who is also a character in the story, using 'I'?","choices":["Third person omniscient","First person narration","Second person narration","Third person limited"],"a":1},{"q":"Which term describes a painting style using very small, distinct dots of colour, pioneered by Georges Seurat?","choices":["Cubism","Pointillism","Fauvism","Expressionism"],"a":1}],"challenge":null,"music":null,"bonus":{"kind":"countdown","numbers":[50,9,100,4,7,6],"target":429},"teen":{"label":"Sport","q":"What is the name of the AFL team based on the Gold Coast?","choices":["Suns","Lions","Titans","Dolphins"],"a":0}},{"week":28,"term":3,"weekInTerm":8,"focus":"zest","plan":["virtue","gk","rebus","gk","gk","gk","char","gk","teen","gk"],"virtueQ":{"q":"Which VIA character strength is being described? \"You bring energy with you. Days feel like something to be used rather than gotten through, and your enthusiasm tends to be contagious.\"","choices":["Perseverance","Bravery","Honesty","Zest"],"a":3},"rebus":{"clue":"<span class=\"ring word\"><span style=\"position:absolute;left:50%;top:50%;transform:translate(-50%,-50%) rotate(0.0deg) translateY(-1.15em) rotate(0deg)\">F</span><span style=\"position:absolute;left:50%;top:50%;transform:translate(-50%,-50%) rotate(51.4deg) translateY(-1.15em) rotate(0deg)\">O</span><span style=\"position:absolute;left:50%;top:50%;transform:translate(-50%,-50%) rotate(102.9deg) translateY(-1.15em) rotate(0deg)\">O</span><span style=\"position:absolute;left:50%;top:50%;transform:translate(-50%,-50%) rotate(154.3deg) translateY(-1.15em) rotate(0deg)\">L</span><span style=\"position:absolute;left:50%;top:50%;transform:translate(-50%,-50%) rotate(205.7deg) translateY(-1.15em) rotate(0deg)\">I</span><span style=\"position:absolute;left:50%;top:50%;transform:translate(-50%,-50%) rotate(257.1deg) translateY(-1.15em) rotate(0deg)\">N</span><span style=\"position:absolute;left:50%;top:50%;transform:translate(-50%,-50%) rotate(308.6deg) translateY(-1.15em) rotate(0deg)\">G</span></span>","answer":"Fooling around","accepted":["fooling around","fool around","foolin around","fooling about"]},"gk":[{"q":"Which river flows through Baghdad, in the historic region of Mesopotamia?","choices":["The Nile","The Tigris","The Euphrates","The Jordan"],"a":1},{"q":"Which ancient wonder of the world was a lighthouse located in Alexandria, Egypt?","choices":["The Colossus of Rhodes","The Lighthouse of Alexandria","The Hanging Gardens","The Temple of Artemis"],"a":1},{"q":"What is 2 to the power of 5 (2⁵)?","choices":["10","16","32","64"],"a":2},{"q":"Which planet is known for its very slow rotation, with a day longer than Mercury's year?","choices":["Mars","Jupiter","Venus","Saturn"],"a":2},{"q":"Which document is regarded as the foundation of Australia's system of government, in effect since 1901?","choices":["The Magna Carta","The Australian Constitution","The Statute of Westminster","The Treaty of Versailles"],"a":1},{"q":"Which classic novel begins with the line 'Call me Ishmael'?","choices":["Moby Dick","Treasure Island","The Old Man and the Sea","Robinson Crusoe"],"a":0}],"challenge":null,"music":null,"bonus":null,"teen":{"label":"TV & movies","q":"Which film franchise features the toys Woody and Buzz Lightyear?","choices":["Cars","Shrek","Toy Story","Madagascar"],"a":2},"char":{"name":"Nemo","aspect":0.543,"bands":[["#fb7816",0.2381],["#f7f8fb",0.0476],["#fa791a",0.0667],["#fafbfd",0.0381],["#fa7918",0.0952],["#090207",0.019],["#fef8fc",0.0952],["#0f0203",0.0286],["#f97a1a",0.1238]],"accepted":["nemo","finding nemo","nemo the clownfish"]}},{"week":29,"term":3,"weekInTerm":9,"focus":"bravery","plan":["music","char","gk","gk","virtue","gk","gk","gk","gk","teen"],"virtueQ":{"q":"Which VIA character strength is being described? \"Discomfort doesn't decide your actions. Whether it's a hard conversation or an unpopular stance, you'd rather act on your convictions than stay safely quiet.\"","choices":["Zest","Bravery","Honesty","Perseverance"],"a":1},"rebus":{"clue":"<span class=\"stack\"><span><span class=\"word big\">BAD</span></span><span><span class=\"word small\">WOLF</span></span></span>","answer":"Big bad wolf","accepted":["big bad wolf","the big bad wolf","big bad wolfe"]},"gk":[{"q":"Which mountain range forms the traditional boundary between Europe and Asia?","choices":["The Alps","The Ural Mountains","The Carpathians","The Pyrenees"],"a":1},{"q":"Which war was fought between the North and South regions of the United States, 1861-1865?","choices":["The War of Independence","The American Civil War","The Mexican-American War","World War I"],"a":1},{"q":"What is 7 multiplied by 8?","choices":["54","56","58","64"],"a":1},{"q":"What is the name of the boundary around a black hole beyond which nothing can escape?","choices":["The photon sphere","The event horizon","The accretion disc","The singularity point"],"a":1},{"q":"What is the study of how societies produce, distribute and consume goods and services called?","choices":["Sociology","Economics","Anthropology","Political science"],"a":1},{"q":"What is the term for a piece of writing about a person's own life, written by that person?","choices":["A biography","An autobiography","A memoir","A eulogy"],"a":1}],"challenge":null,"music":{"notes":[["C4",1],["C4",1],["C4",0.75],["D4",0.25],["E4",2],["E4",1]],"tempoMs":190,"choices":["Beethoven's Symphony No. 5","Mary Had a Little Lamb","London Bridge Is Falling Down","Row Row Row Your Boat"],"a":3},"bonus":null,"teen":{"label":"Sport","q":"Which two states play each other in the State of Origin rugby league series?","choices":["Queensland and Victoria","Queensland and New South Wales","New South Wales and Victoria","Queensland and Western Australia"],"a":1},"char":{"name":"Cheshire Cat","aspect":0.533,"bands":[["#94235a",0.0952],["#f85bc9",0.1238],["#fdfafd",0.0952],["#f15ecc",0.0476],["#8d4baf",0.0571],["#f05dd2",0.0381],["#914db0",0.0667],["#ef5dcf",0.0571],["#934db0",0.0667],["#f25dd2",0.0476],["#944cb0",0.0667],["#f25ccf",0.0571],["#894dae",0.0571],["#f25fcb",0.0571]],"accepted":["cheshire cat","cheshire","the cheshire cat","alice in wonderland cat","cheshire cat alice in wonderland"]}},{"week":30,"term":3,"weekInTerm":10,"focus":"perseverance","plan":["char","gk","teen","gk","gk","gk","virtue","rebus","gk","gk"],"virtueQ":{"q":"Which VIA character strength is being described? \"Once you've started something, abandoning it doesn't sit right. Obstacles tend to sharpen your focus rather than drain it.\"","choices":["Perseverance","Bravery","Zest","Honesty"],"a":0},"rebus":{"clue":"<span class=\"stack\"><span><span class=\"word compact\">Keep your iiii</span></span><span>⚽</span></span>","answer":"Keep your eyes on the ball","accepted":["keep your eyes on the ball","keep your eye on the ball","eyes on the ball","eye on the ball","keep eyes on the ball"]},"gk":[{"q":"Which video game, released in 2011, lets players mine and build with blocks?","choices":["Fortnite","Roblox","Among Us","Minecraft"],"a":3},{"q":"What is the capital city of Kazakhstan?","choices":["Almaty","Astana","Tashkent","Bishkek"],"a":1},{"q":"Who was Australia's first Prime Minister?","choices":["Andrew Fisher","Edmund Barton","Alfred Deakin","Billy Hughes"],"a":1},{"q":"What is 15% of 200?","choices":["20","25","30","35"],"a":2},{"q":"Which planet's moons include Titan, the second-largest moon in the solar system?","choices":["Jupiter","Saturn","Uranus","Neptune"],"a":1},{"q":"Which voting system is used for elections to Australia's House of Representatives, where voters rank candidates in order of preference?","choices":["First-past-the-post","Preferential (ranked-choice) voting","Proportional representation only","Approval voting"],"a":1}],"challenge":null,"music":null,"bonus":null,"teen":{"label":"Music","q":"Which singer had a huge hit with the song 'Flowers' in 2023?","choices":["Miley Cyrus","Ariana Grande","Sabrina Carpenter","Selena Gomez"],"a":0},"char":{"name":"Shaggy","aspect":0.543,"bands":[["#cfa15e",0.1064],["#f1cda9",0.1755],["#b6d869",0.3191],["#ac986c",0.2979],["#3e3c3e",0.0638]],"accepted":["shaggy","shaggy rogers","norville rogers","shaggy from scooby doo","shaggy scooby doo","scooby doo shaggy"]}},{"week":31,"term":4,"weekInTerm":1,"focus":"honesty","plan":["gk","gk","rebus","char","teen","gk","gk","gk","virtue","gk"],"virtueQ":{"q":"Which VIA character strength is being described? \"What people see from you is what's actually there. You'd rather deliver an uncomfortable truth than maintain a comfortable pretence.\"","choices":["Honesty","Perseverance","Bravery","Zest"],"a":0},"rebus":{"clue":"<span class=\"overlay\"><span class=\"bg\">👁️</span><span class=\"fg\">look me</span></span>","answer":"Look me in the eye","accepted":["look me in the eye","look me in the eyes","look me in my eye","look in the eye","look at me in the eye"]},"gk":[{"q":"Which country is the world's largest producer of coffee beans?","choices":["Colombia","Vietnam","Brazil","Ethiopia"],"a":2},{"q":"In which year did the Berlin Wall fall?","choices":["1979","1985","1989","1991"],"a":2},{"q":"What do you call two angles that add up to 180 degrees?","choices":["Complementary angles","Supplementary angles","Adjacent angles","Corresponding angles"],"a":1},{"q":"Which Australian city is most at risk from tropical cyclones due to its location?","choices":["Adelaide","Darwin","Hobart","Melbourne"],"a":1},{"q":"How many rings appear on the Olympic flag?","choices":["4","5","6","7"],"a":1},{"q":"In 'The Wizard of Oz', what is the name of Dorothy's dog?","choices":["Toto","Rex","Buddy","Max"],"a":0}],"challenge":null,"music":null,"bonus":null,"teen":{"label":"School subjects","q":"What does 'arigatō' mean in Japanese?","choices":["Good morning","Goodbye","Thank you","Sorry"],"a":2},"char":{"name":"Mario","aspect":0.7,"bands":[["#b70505",0.0933],["#cba47f",0.18],["#ba0303",0.1133],["#0b2b88",0.0667],["#efff25",0.0133],["#042f8d",0.2533],["#292d64",0.0133],["#843f19",0.1333],["#fdece3",0.0133]],"accepted":["mario","super mario","mario bros","mario brothers","super mario bros","super mario brothers","nintendo mario"]}},{"week":32,"term":4,"weekInTerm":2,"focus":"courageReview","plan":["gk","gk","gk","teen","gk","gk","gk","gk","rebus","virtue"],"virtueQ":{"q":"Which four strengths make up the virtue of Courage?","choices":["Bravery, Perseverance, Honesty, Zest","Love, Kindness, Fairness, Hope","Curiosity, Judgement, Creativity, Perspective","Humility, Prudence, Forgiveness, Self-Regulation"],"a":0},"rebus":{"clue":"<span class=\"stack\"><span><span>🌭</span></span><span><span class=\"word\">THE</span></span></span>","answer":"The underdog","accepted":["the underdog","underdog","under dog","an underdog","the under dog"]},"gk":[{"q":"Which country dropped the first atomic bombs used in war, in 1945?","choices":["Germany","Soviet Union","United States","United Kingdom"],"a":2},{"q":"Which empire, centred on Rome, eventually split into Western and Eastern halves?","choices":["The Persian Empire","The Roman Empire","The Ottoman Empire","The Mongol Empire"],"a":1},{"q":"What is the value of pi (π), rounded to two decimal places?","choices":["3.14","3.41","3.12","3.16"],"a":0},{"q":"Which of these describes 'natural selection', as proposed by Charles Darwin?","choices":["Organisms choosing their own mutations","Traits that aid survival becoming more common over generations","Every species evolving at the same rate","Animals adapting within a single lifetime"],"a":1},{"q":"What does the abbreviation 'URL' stand for?","choices":["Uniform Resource Locator","Universal Reference Link","United Resource Listing","Unified Redirect Location"],"a":0},{"q":"Which author wrote the original Harry Potter book series?","choices":["J.R.R. Tolkien","J.K. Rowling","Roald Dahl","C.S. Lewis"],"a":1},{"q":"What term describes an animal that generates most of its body heat internally to help maintain its body temperature?","choices":["Ectotherm","Endotherm","Poikilotherm","Reptile"],"a":1}],"challenge":null,"music":null,"bonus":null,"teen":{"label":"Music","q":"Which singer-songwriter had a worldwide hit with 'Shape of You'?","choices":["Shawn Mendes","Harry Styles","Ed Sheeran","Justin Bieber"],"a":2}},{"week":33,"term":4,"weekInTerm":3,"focus":"temperanceIntro","plan":["music","gk","gk","virtue","gk","char","rebus","teen","gk","gk"],"virtueQ":{"q":"Which virtue groups together the strengths Forgiveness, Humility, Prudence, Self-Regulation?","choices":["Wisdom","Courage","Temperance","Humanity"],"a":2},"rebus":{"clue":"<span class=\"overlay\"><span class=\"bg\">🦷</span><span class=\"fg\">sugar</span></span>","answer":"Sweet tooth","accepted":["sweet tooth","a sweet tooth","sugar tooth","sweet teeth"]},"gk":[{"q":"Which ancient civilisation is associated with the development of cuneiform, one of the earliest known writing systems?","choices":["Egypt","Sumer (Mesopotamia)","China","Greece"],"a":1},{"q":"Which vitamin does the human body produce when skin is exposed to sunlight?","choices":["Vitamin A","Vitamin C","Vitamin D","Vitamin K"],"a":2},{"q":"Which of these fractions is equivalent to 0.75?","choices":["1/2","2/3","3/4","4/5"],"a":2},{"q":"What do you call the network of underground water sources beneath much of inland Australia?","choices":["The Nullarbor Aquifer","The Great Artesian Basin","The Murray Basin","The Simpson Reservoir"],"a":1},{"q":"In which year was the first Apple iPhone released?","choices":["2001","2004","2007","2010"],"a":2}],"challenge":null,"music":{"notes":[["C4",1],["D4",1],["E4",1],["C4",1],["C4",1],["D4",1],["E4",1],["C4",1],["E4",1]],"tempoMs":220,"choices":["Frere Jacques","Old MacDonald Had a Farm","Hot Cross Buns","Ode to Joy"],"a":0},"bonus":null,"teen":{"label":"Sport","q":"Which country won the 2022 FIFA World Cup in Qatar?","choices":["France","Brazil","Argentina","Croatia"],"a":2},"char":{"name":"Fred Flintstone","aspect":0.59,"bands":[["#f5fb34",0.0694],["#e3b58a",0.2717],["#bc5901",0.3642],["#eebe90",0.2543]],"accepted":["fred flintstone","fred","flintstone","fred flinstone","the flintstones fred","fred from the flintstones"]}},{"week":34,"term":4,"weekInTerm":4,"focus":"prudence","plan":["gk","gk","char","gk","virtue","gk","teen","gk","gk","gk"],"virtueQ":{"q":"Which VIA character strength is being described? \"You look before you leap, habitually. Choices get weighed against where they lead, not just how they feel right now.\"","choices":["Forgiveness","Humility","Prudence","Self-Regulation"],"a":2},"rebus":{"clue":"<span class=\"stack\"><span><span class=\"word giant\">sleep</span></span><span><span class=\"word small\">it</span></span></span>","answer":"Sleep on it","accepted":["sleep on it","sleeping on it","sleep over it","sleep on that","sleep upon it"]},"gk":[{"q":"What is the capital city of Canada?","choices":["Toronto","Vancouver","Ottawa","Montreal"],"a":2},{"q":"Which part of the brain is mainly responsible for balance and coordination?","choices":["Cerebrum","Cerebellum","Medulla","Hypothalamus"],"a":1},{"q":"What do you call an angle that measures exactly 90 degrees?","choices":["An acute angle","A right angle","An obtuse angle","A reflex angle"],"a":1},{"q":"What is the name for a large, rotating storm system that forms over warm tropical oceans (called a hurricane in the Atlantic)?","choices":["A tornado","A cyclone","A blizzard","A monsoon"],"a":1},{"q":"In Australian Rules football, how many points is a goal (through the main posts) worth?","choices":["1","3","6","10"],"a":2},{"q":"What do you call the main message or lesson of a piece of literature?","choices":["The plot","The theme","The setting","The climax"],"a":1},{"q":"Which introduced animal, brought to control cane beetles, became a major pest in Australia?","choices":["The cane toad","The European rabbit","The red fox","The feral cat"],"a":0}],"challenge":null,"music":null,"bonus":null,"teen":{"label":"TV & movies","q":"Which Marvel hero is known as the 'God of Thunder'?","choices":["Hulk","Loki","Black Panther","Thor"],"a":3},"char":{"name":"Wally","aspect":0.451,"bands":[["#bf4b4c",0.0217],["#fdfaf7",0.0272],["#c24f4a",0.0217],["#9f6943",0.0109],["#ecbe92",0.1793],["#cb3c37",0.038],["#fffdf9",0.0217],["#c5362b",0.0272],["#fefafa",0.0217],["#c43f3a",0.0326],["#fefcf7",0.0217],["#c03834",0.0217],["#fff8f8",0.0217],["#c43e38",0.038],["#fdfafa",0.0217],["#3282cd",0.2283],["#bc9552",0.0761]],"accepted":["wally","waldo","where's wally","wheres wally","where's waldo","wheres waldo","wally from where's wally","waldo from where's waldo"]}},{"week":35,"term":4,"weekInTerm":5,"focus":"humility","plan":["gk","char","gk","teen","gk","gk","gk","rebus","virtue","gk"],"virtueQ":{"q":"Which VIA character strength is being described? \"You don't need to be the headline. Your work can speak for itself, and you take feedback without bristling.\"","choices":["Prudence","Forgiveness","Self-Regulation","Humility"],"a":3},"rebus":{"clue":"<span class=\"word\"><span class=\"lc\">po</span><span class=\"big\">FISH</span><span class=\"lc\">nd</span></span>","answer":"Big fish in a little pond","accepted":["big fish in a little pond","big fish in a small pond","big fish little pond","a big fish in a little pond","big fish small pond"]},"gk":[{"q":"Which lake is the lowest natural point in Australia, sitting below sea level?","choices":["Lake Eyre","Lake George","Lake Mungo","Lake Argyle"],"a":0},{"q":"What is the term for two different elements combining in fixed proportions to form a new substance?","choices":["A mixture","A compound","A solution","A suspension"],"a":1},{"q":"If a rectangle has a length of 12 cm and a width of 5 cm, what is its area?","choices":["17 cm²","34 cm²","60 cm²","85 cm²"],"a":2},{"q":"What do you call rock formed from cooled and solidified lava or magma?","choices":["Sedimentary rock","Igneous rock","Metamorphic rock","Organic rock"],"a":1},{"q":"What is the maximum possible score in a single game of ten-pin bowling?","choices":["150","250","300","500"],"a":2},{"q":"Who wrote the play 'Romeo and Juliet'?","choices":["Charles Dickens","William Shakespeare","Jane Austen","Christopher Marlowe"],"a":1}],"challenge":null,"music":null,"bonus":{"kind":"countdown","numbers":[25,9,5,1,4,3],"target":636},"teen":{"label":"Music","q":"Which Australian producer is known for the songs 'Never Be Like You' and 'Say It'?","choices":["Alison Wonderland","Flume","Peking Duk","Hilltop Hoods"],"a":1},"char":{"name":"Santa Claus","aspect":0.543,"bands":[["#fff2e3",0.0054],["#f52018",0.086],["#fcf9f8",0.0269],["#ebbe93",0.1452],["#fdfdf7",0.0753],["#f52318",0.0968],["#050001",0.0591],["#ee2318",0.0269],["#fcfaf8",0.0699],["#f92116",0.1344],["#fef7f5",0.0323],["#000000",0.129]],"accepted":["santa","santa claus","santa clause","father christmas","saint nick","st nick","saint nicholas","st nicholas","kris kringle","santa clause"]}},{"week":36,"term":4,"weekInTerm":6,"focus":"regulation","plan":["gk","char","gk","gk","teen","gk","gk","virtue","rebus","gk"],"virtueQ":{"q":"Which VIA character strength is being described? \"You run yourself with discipline. Impulses and moods get a vote but not a veto.\"","choices":["Prudence","Self-Regulation","Humility","Forgiveness"],"a":1},"rebus":{"clue":"<span class=\"word huge\">↑</span><span class=\"word\">uu</span>","answer":"Up to you","accepted":["up to you","its up to you","it's up to you","up 2 you","up two you"]},"gk":[{"q":"Which country has the most time zones of any nation, mainly due to its overseas territories?","choices":["Russia","United States","France","China"],"a":2},{"q":"Which gas do humans exhale in a higher concentration than they inhale?","choices":["Oxygen","Nitrogen","Carbon dioxide","Hydrogen"],"a":2},{"q":"If you flip a fair coin twice, what is the probability of getting two heads in a row?","choices":["1/2","1/3","1/4","1/8"],"a":2},{"q":"Which Australian bird is famous for its laughing call?","choices":["Magpie","Kookaburra","Galah","Cockatoo"],"a":1},{"q":"Which natural disaster is measured using the moment magnitude scale (commonly still called the Richter scale)?","choices":["Cyclones","Volcanic eruptions","Earthquakes","Floods"],"a":2},{"q":"What does the abbreviation 'AI', as in artificial intelligence, generally refer to?","choices":["Automated Internet","Artificial Intelligence","Applied Informatics","Advanced Integration"],"a":1}],"challenge":null,"music":null,"bonus":null,"teen":{"label":"School subjects","q":"Which three colours are the primary colours of paint?","choices":["Red, green and blue","Orange, green and purple","Black, white and grey","Red, yellow and blue"],"a":3},"char":{"name":"Oscar the Grouch","aspect":0.55,"bands":[["#d7cfcc",0.07],["#a65a2a",0.02],["#7fb834",0.13],["#3b6e1c",0.02],["#d7cfcc",0.76]],"accepted":["oscar the grouch","oscar","oscar grouch","the grouch","oscar from sesame street","oscar sesame street"]}},{"week":37,"term":4,"weekInTerm":7,"focus":"forgiveness","plan":["virtue","teen","gk","gk","gk","music","gk","gk","gk","rebus"],"virtueQ":{"q":"Which VIA character strength is being described? \"You give people a way back. Holding onto resentment strikes you as a poor trade.\"","choices":["Forgiveness","Humility","Self-Regulation","Prudence"],"a":0},"rebus":{"clue":"<span class=\"stack\"><span><span class=\"word compact\">GIVE &nbsp;&nbsp; GET</span></span><span><span class=\"word compact\">GIVE &nbsp;&nbsp; GET</span></span><span><span class=\"word compact\">GIVE &nbsp;&nbsp; GET</span></span><span><span class=\"word compact\">GIVE &nbsp;&nbsp; GET</span></span></span>","answer":"Forgive and forget","accepted":["forgive and forget","forgive forget","forgive & forget","forget and forgive","forgive and forgot"]},"gk":[{"q":"Which Australian state's capital is Hobart?","choices":["Victoria","Tasmania","South Australia","Western Australia"],"a":1},{"q":"Which type of chemical bond involves atoms sharing electron pairs?","choices":["Ionic bond","Covalent bond","Metallic bond","Hydrogen bond"],"a":1},{"q":"What do you call the number that appears most often in a data set?","choices":["The mean","The median","The mode","The range"],"a":2},{"q":"What do you call the scientific study of earthquakes and seismic waves?","choices":["Volcanology","Seismology","Meteorology","Geodesy"],"a":1},{"q":"How many Grand Slam tennis tournaments are held each year?","choices":["2","3","4","6"],"a":2},{"q":"Which Shakespeare play features the characters Macbeth and Lady Macbeth?","choices":["Hamlet","Macbeth","Othello","King Lear"],"a":1}],"challenge":null,"music":{"notes":[["G4",0.75],["G4",0.25],["A4",1],["G4",1],["C5",1],["B4",2],["G4",0.75],["G4",0.25]],"tempoMs":420,"choices":["Happy Birthday","Ode to Joy","Fur Elise","Beethoven's Symphony No. 5"],"a":0},"bonus":null,"teen":{"label":"TV & movies","q":"Which film opened on the same day as 'Barbie' in 2023, creating the 'Barbenheimer' craze?","choices":["Oppenheimer","Dune","The Flash","Mission: Impossible"],"a":0}},{"week":38,"term":4,"weekInTerm":8,"focus":"yearReview","plan":["gk","teen","virtue","gk","gk","gk","rebus","char","gk","gk"],"virtueQ":{"q":"Using your character strengths in new ways, more often, is linked to —","choices":["greater happiness and life satisfaction","losing marks in exams","having to do more homework","nothing — strengths don't actually make a difference"],"a":0},"rebus":{"clue":"<span class=\"word italic\">ECNALG</span>","answer":"A backwards glance","accepted":["a backwards glance","backwards glance","a backward glance","backward glance","backwards glancing"]},"gk":[{"q":"Which country is both in Europe and Asia, straddling the Bosphorus strait?","choices":["Russia","Turkey","Kazakhstan","Georgia"],"a":1},{"q":"Which subatomic particle carries a negative electric charge?","choices":["Proton","Neutron","Electron","Photon"],"a":2},{"q":"What is the term for the top number in a fraction?","choices":["The denominator","The numerator","The quotient","The divisor"],"a":1},{"q":"Which of these best describes an ecosystem's 'trophic level'?","choices":["Its position in a food chain, based on what it eats","Its total land area","Its rate of population growth","Its distance from the equator"],"a":0},{"q":"What does the abbreviation 'HTTP' stand for?","choices":["HyperText Transfer Protocol","High Transfer Text Program","Home Text Transport Protocol","Hyperlink Text Transport Path"],"a":0},{"q":"In which Shakespeare play does the phrase 'To be, or not to be' appear?","choices":["Macbeth","Hamlet","Othello","The Tempest"],"a":1}],"challenge":null,"music":null,"bonus":null,"teen":{"label":"Sport","q":"In cricket, what is it called when a bowler takes wickets with three balls in a row?","choices":["A century","A maiden","A triple play","A hat-trick"],"a":3},"char":{"name":"Tony the Tiger","aspect":0.536,"bands":[["#020102",0.0816],["#f3d556",0.0153],["#145997",0.0153],["#fbfbf8",0.102],["#c32818",0.0561],["#f1902c",0.051],["#020000",0.1122],["#f5932e",0.0255],["#040201",0.0612],["#f19230",0.0459],["#020001",0.0561],["#f39e42",0.0153],["#070000",0.0255],["#e99532",0.0255],["#010001",0.0561],["#e79032",0.0306]],"accepted":["tony the tiger","tony tiger","tony","frosties tiger","frosted flakes tiger","kellogg's tiger","kelloggs tiger"]}},{"week":39,"term":4,"weekInTerm":9,"focus":"lookingAhead","plan":["gk","gk","gk","gk","virtue","gk","char","gk","teen","gk"],"virtueQ":{"q":"In PERMAH, what does the 'A' stand for?","choices":["Attitude","Accomplishment","Ambition","Achievement only"],"a":1},"rebus":{"clue":"<span class=\"cornerbox\"><span class=\"just\">JUST</span></span>","answer":"Just around the corner","accepted":["just around the corner","around the corner","just round the corner","just around corner"]},"gk":[{"q":"What is the currency of Switzerland?","choices":["Euro","Swiss Franc","Krone","Peso"],"a":1},{"q":"Which of Newton's Laws states that every action has an equal and opposite reaction?","choices":["First Law","Second Law","Third Law","Law of Gravitation"],"a":2},{"q":"Which shape has exactly one pair of parallel sides?","choices":["A rectangle","A trapezium","A rhombus","A parallelogram"],"a":1},{"q":"Which of these countries sits on the 'Ring of Fire', with frequent earthquakes and volcanoes?","choices":["Egypt","Japan","France","Poland"],"a":1},{"q":"In chess, what is it called when a king is under direct attack and cannot escape?","choices":["Stalemate","Check","Checkmate","Castling"],"a":2},{"q":"What is the term for a story that uses characters and events to represent a deeper moral or political meaning?","choices":["A memoir","An allegory","A biography","A satire only"],"a":1},{"q":"Which Australian mammal is a monotreme, meaning it lays eggs rather than giving birth to live young?","choices":["Wombat","Echidna","Bilby","Numbat"],"a":1}],"challenge":null,"music":null,"bonus":null,"teen":{"label":"School subjects","q":"About how many hours of sleep per night do health experts recommend for teenagers?","choices":["4 to 5 hours","6 hours","8 to 10 hours","12 to 13 hours"],"a":2},"char":{"name":"Popeye","aspect":0.47,"bands":[["#f9d9c8",0.24],["#b3262a",0.03],["#111111",0.27],["#e8d28a",0.03],["#1789a3",0.27],["#b5740f",0.12]],"accepted":["popeye","popeye the sailor","popeye the sailor man","popeye sailor man"]}},{"week":40,"term":4,"weekInTerm":10,"focus":"celebrateReset","plan":["virtue","gk","char","gk","rebus","gk","gk","gk","gk","teen"],"virtueQ":{"q":"In PERMAH, what does the final letter 'H' stand for?","choices":["Happiness","Habits","Health","Honesty"],"a":2},"rebus":{"clue":"<span class=\"stack ovation\"><span><span class=\"word\">O</span></span><span><span class=\"word\">V</span></span><span><span class=\"word\">A</span></span><span><span class=\"word\">T</span></span><span><span class=\"word\">I</span></span><span><span class=\"word\">O</span></span><span><span class=\"word\">N</span></span></span>","answer":"Standing ovation","accepted":["standing ovation","a standing ovation","stand ovation","standing ovations"]},"gk":[{"q":"Which country uses the yen as its official currency?","choices":["China","Japan","South Korea","Thailand"],"a":1},{"q":"What do you call an organism that can make its own food using sunlight, water and carbon dioxide?","choices":["A consumer","A producer","A decomposer","A scavenger"],"a":1},{"q":"What is the square root of 144?","choices":["11","12","13","14"],"a":1},{"q":"What is the term for rock being broken down in place by wind, water, or ice, without being moved?","choices":["Erosion","Weathering","Deposition","Sedimentation"],"a":1},{"q":"In cricket, what is the term for a batter scoring 100 runs in a single innings?","choices":["A double","A ton","A hundred (a century)","A grand slam"],"a":2},{"q":"Which artist is known for cutting off part of his own ear and for paintings like 'The Starry Night'?","choices":["Pablo Picasso","Claude Monet","Vincent van Gogh","Salvador Dali"],"a":2}],"challenge":null,"music":null,"bonus":null,"teen":{"label":"TV & movies","q":"In the animated series 'Avatar: The Last Airbender', what is the name of Aang's flying bison?","choices":["Momo","Appa","Naga","Pabu"],"a":1},"char":{"name":"Papa Smurf","aspect":0.47,"bands":[["#ee1d27",0.15],["#67bbe9",0.12],["#ffffff",0.17],["#67bbe9",0.25],["#ee1d27",0.31]],"accepted":["papa smurf","papa smurph","papa","papa smurf smurfs"]}}];


function cshsAbsWeek(){
  try{
    var terms=window.CSHS_SITE_CONFIG.terms;
    var pd=function(s){var a=s.split('-');return new Date(+a[0],+a[1]-1,+a[2]);};
    var monday=function(d){var x=new Date(d);x.setDate(x.getDate()-((x.getDay()+6)%7));x.setHours(0,0,0,0);return x;};
    var today=new Date(); today.setHours(0,0,0,0);
    var abs=0, current=0;
    for(var i=0;i<terms.length;i++){
      var end=pd(terms[i].end), m=monday(pd(terms[i].start));
      while(m<=end){ abs++; if(m<=today){ current=abs; } m=new Date(m); m.setDate(m.getDate()+7); }
    }
    return current;
  }catch(e){ return 0; }
}

const STAGE_KIND_LABELS = {
  virtue: "This week's focus", rebus: "Crack the Code", char: "Name that character",
  gk: "General knowledge",
  music: "Name that tune",
};
let round = null, stage = 0, score = 0, answered = false;

function currentWeekRound(){
  const abs = cshsAbsWeek();
  const idx = (abs >= 1 && abs <= ROUNDS.length) ? abs - 1 : 0;
  return ROUNDS[idx];
}

// Pure function of `stage` — safe to call more than once per stage without
// side effects (e.g. from a debugger or a test harness peeking ahead).
function stageData(){
  const kind = round.plan[stage];
  if (kind === 'virtue') return {kind:'text', ...round.virtueQ};
  if (kind === 'rebus') return {kind:'typed', clue: round.rebus.clue, accepted: round.rebus.accepted, answer: round.rebus.answer};
  if (kind === 'char') return {kind:'char', strip: round.char, accepted: round.char.accepted, answer: round.char.name};
  if (kind === 'gk') {
    const gkIndex = round.plan.slice(0, stage).filter(k => k === 'gk').length;
    return {kind:'text', ...round.gk[gkIndex]};
  }
  if (kind === 'teen') return {kind:'text', ...round.teen};
  if (kind === 'music') return {kind:'music', notes: round.music.notes, tempoMs: round.music.tempoMs, choices: round.music.choices, a: round.music.a};
  return null;
}

function seededShuffle(arr, seed){
  const a=[...arr]; let s=seed;
  for(let i=a.length-1;i>0;i--){ s=(s*9301+49297)%233280; const j=Math.floor((s/233280)*(i+1)); [a[i],a[j]]=[a[j],a[i]]; }
  return a;
}
function norm(s){ return String(s||'').toLowerCase().replace(/[^a-z0-9]/g,''); }

/* ── NAME THAT TUNE (synthesised, no audio files) ── */
let audioCtx = null;
function noteFreq(note){
  const m = note.match(/^([A-G])(#|b)?(\d)$/);
  const SEMITONE = {C:-9,D:-7,E:-5,F:-4,G:-2,A:0,B:2};
  let n = SEMITONE[m[1]] + (m[2]==='#'?1:m[2]==='b'?-1:0) + (parseInt(m[3],10)-4)*12;
  return 440 * Math.pow(2, n/12);
}
function playMelody(notes, tempoMs=320){
  if (!audioCtx) audioCtx = new (window.AudioContext || window.webkitAudioContext)();
  if (audioCtx.state === 'suspended') audioCtx.resume();
  let t = audioCtx.currentTime + 0.05;
  notes.forEach(([note, beats]) => {
    const dur = (beats * tempoMs) / 1000;
    const osc = audioCtx.createOscillator();
    const gain = audioCtx.createGain();
    osc.type = 'sine';
    osc.frequency.value = noteFreq(note);
    gain.gain.setValueAtTime(0.0001, t);
    gain.gain.linearRampToValueAtTime(0.25, t + 0.02);
    gain.gain.setValueAtTime(0.25, t + dur*0.8);
    gain.gain.linearRampToValueAtTime(0.0001, t + dur*0.95);
    osc.connect(gain).connect(audioCtx.destination);
    osc.start(t);
    osc.stop(t + dur);
    t += dur;
  });
}

const weekTag=document.getElementById('weekTag'),progressDots=document.getElementById('progressDots'),
  stageLabel=document.getElementById('stageLabel'),questionBox=document.getElementById('questionBox'),
  choicesBox=document.getElementById('choicesBox'),
  feedback=document.getElementById('feedback'),noteBox=document.getElementById('noteBox'),
  nextBtn=document.getElementById('nextBtn'),playView=document.getElementById('playView'),
  resultView=document.getElementById('resultView'),scoreBig=document.getElementById('scoreBig'),
  scoreSub=document.getElementById('scoreSub'),timerDisplay=document.getElementById('timerDisplay'),
  bonusLine=document.getElementById('bonusLine'),bonusView=document.getElementById('bonusView');

/* ── TIMER ──
   The elapsed time is shown on the results screen only; it does not
   affect the score submitted to the leaderboard. */
let startTime = null, timerInterval = null, finalElapsedSeconds = 0;
function fmtTime(totalSeconds){
  const m = Math.floor(totalSeconds / 60), s = totalSeconds % 60;
  return String(m).padStart(2,'0') + ':' + String(s).padStart(2,'0');
}
function startTimer(){
  startTime = Date.now();
  timerDisplay.textContent = '00:00';
  if (timerInterval) clearInterval(timerInterval);
  timerInterval = setInterval(() => {
    const elapsed = Math.floor((Date.now() - startTime) / 1000);
    timerDisplay.textContent = fmtTime(elapsed);
  }, 250);
}
function stopTimer(){
  if (timerInterval) { clearInterval(timerInterval); timerInterval = null; }
  finalElapsedSeconds = startTime ? Math.floor((Date.now() - startTime) / 1000) : 0;
  return finalElapsedSeconds;
}

function renderProgress(){
  progressDots.innerHTML = round.plan.map((_,i)=>{
    const cls = i < stage ? 'dot done' : (i === stage ? 'dot current' : 'dot');
    return `<span class="${cls}"></span>`;
  }).join('');
}

function renderStage(){
  answered = false;
  nextBtn.disabled = true;
  nextBtn.textContent = stage === round.plan.length - 1 ? 'See results' : 'Next round';
  feedback.textContent = '';
  feedback.className = 'feedback';
  noteBox.className = 'note-box';
  noteBox.textContent = '';
  renderProgress();
  const d = stageData();
  stageLabel.textContent = round.plan[stage] === 'teen' ? round.teen.label : STAGE_KIND_LABELS[round.plan[stage]];

  if (d.kind === 'typed') {
    questionBox.innerHTML = `<div class="rebus-stack"><div class="rebus-clue">${d.clue}</div><div class="rebus-hint">${(n => n + (n === 1 ? ' word' : ' words'))(d.answer.replace(/-/g, ' ').trim().split(/\s+/).length)}</div></div>`;
  } else if (d.kind === 'char') {
    questionBox.innerHTML = '<div class="char-box"><div class="char-strip" id="charStrip"></div><div class="char-note">The colours of a famous character, from the top of their body to the bottom. Type who it is.</div></div>';
    const strip = document.getElementById('charStrip');
    strip.style.width = Math.round(190 * d.strip.aspect) + 'px';
    d.strip.bands.forEach(([hex, frac]) => {
      if (!/^#[0-9a-f]{6}$/i.test(hex)) return;
      const band = document.createElement('div');
      band.style.background = hex;
      band.style.flex = (frac * 1000) + ' 1 0';
      strip.appendChild(band);
    });
  } else if (d.kind === 'music') {
    questionBox.innerHTML = `<div class="music-box"><button class="btn btn-primary music-play-btn" id="playMelodyBtn" type="button">▶ Play melody</button><div class="music-hint">Tap to play — replay as many times as you like</div></div>`;
    document.getElementById('playMelodyBtn').addEventListener('click', () => playMelody(d.notes, d.tempoMs));
  } else {
    questionBox.innerHTML = `<div class="question-text"></div>`;
    questionBox.querySelector('.question-text').textContent = d.q;
  }

  choicesBox.innerHTML = '';
  if (d.kind === 'typed' || d.kind === 'char') {
    const input = document.createElement('input');
    input.type = 'text';
    input.className = 'answer-input';
    input.placeholder = 'Type your answer…';
    input.autocomplete = 'off';
    const submitBtn = document.createElement('button');
    submitBtn.className = 'btn btn-outline';
    submitBtn.textContent = 'Submit answer';
    const submit = () => submitTyped(input.value, d);
    submitBtn.addEventListener('click', submit);
    input.addEventListener('keydown', e => { if (e.key === 'Enter') submit(); });
    choicesBox.appendChild(input);
    choicesBox.appendChild(submitBtn);
    input.focus();
  } else {
    d.choices.forEach((choice, i) => {
      const btn = document.createElement('button');
      btn.className = 'choice-btn';
      btn.textContent = choice;
      btn.addEventListener('click', () => selectChoice(i, d));
      choicesBox.appendChild(btn);
    });
  }
}

/* Character answers are typed freely, so they are matched generously: any listed
   name (full, first name, nickname, the show or film they come from), with
   "the/a/an" ignored, a small allowance for typos, and any answer that contains
   a listed name of five letters or more ("it's buzz lightyear from toy story"). */
function lev(a, b){
  const m = a.length, n = b.length;
  let prev = Array.from({length: n + 1}, (_, j) => j);
  for (let i = 1; i <= m; i++) {
    const cur = [i];
    for (let j = 1; j <= n; j++) cur[j] = Math.min(prev[j] + 1, cur[j-1] + 1, prev[j-1] + (a[i-1] === b[j-1] ? 0 : 1));
    prev = cur;
  }
  return prev[n];
}
function charMatch(value, accepted){
  const clean = t => norm(String(t || '').toLowerCase().replace(/^(the|a|an)\s+/, ''));
  const v = clean(value);
  if (!v) return false;
  return accepted.some(a => {
    const t = clean(a);
    if (!t) return false;
    if (v === t) return true;
    if (t.length >= 5 && v.includes(t)) return true;
    const tol = t.length <= 3 ? 0 : (t.length <= 8 ? 1 : 2);
    return tol > 0 && Math.abs(v.length - t.length) <= tol && lev(v, t) <= tol;
  });
}
function submitTyped(value, d){
  if (answered) return;
  answered = true;
  const ok = d.kind === 'char' ? charMatch(value, d.accepted) : d.accepted.some(a => norm(a) === norm(value));
  choicesBox.querySelector('.answer-input').disabled = true;
  choicesBox.querySelector('.btn').disabled = true;
  if (ok) {
    score++;
    feedback.textContent = 'Correct!';
    feedback.className = 'feedback right';
  } else {
    feedback.textContent = `Not quite — the answer was "${d.answer}".`;
    feedback.className = 'feedback wrong';
  }
  nextBtn.disabled = false;
}

function selectChoice(i, d){
  if (answered) return;
  answered = true;
  const buttons = [...choicesBox.querySelectorAll('.choice-btn')];
  buttons.forEach((b, idx) => {
    b.disabled = true;
    if (idx === d.a) b.classList.add('correct');
    else if (idx === i) b.classList.add('wrong');
  });
  if (i === d.a) {
    score++;
    feedback.textContent = 'Correct!';
    feedback.className = 'feedback right';
  } else {
    feedback.textContent = 'Not quite — correct answer highlighted.';
    feedback.className = 'feedback wrong';
  }
  nextBtn.disabled = false;
}

function nextRound(){
  stage++;
  if (stage >= round.plan.length) {
    if (round.bonus && score < round.plan.length) {
      showBonusRound();
    } else {
      showResults();
    }
  } else {
    renderStage();
  }
}

/* ── BONUS ROUND ──
   A redemption shot for a missed question, shown only on the rotating
   subset of weeks that carry one (round.bonus), and only when the group
   actually missed something (nextRound checks score < plan.length first).
   Success recovers exactly one point, capped at a perfect score; failure
   costs nothing further — it's a free attempt. One mechanic, adapted
   from the retired standalone Countdown game. */
let bcNumbers = [], bcUsed = new Set(), bcExpr = '', bcResult = null;
let bonusTimerInterval = null;

function showBonusRound(){
  playView.style.display = 'none';
  bonusView.style.display = '';
  renderProgress();
  document.getElementById('bonusIntro').textContent = "You missed one — here's a shot at winning it back. No penalty if it doesn't land.";
  document.getElementById('bonusFeedback').textContent = '';
  document.getElementById('bonusFeedback').className = 'feedback';
  document.getElementById('bonusContinueBtn').style.display = 'none';
  document.getElementById('bonusCountdown').style.display = '';
  startBonusCountdown();
}

function startBonusTimer(seconds, onExpire, numId, fillId){
  const start = performance.now();
  clearInterval(bonusTimerInterval);
  const numEl = document.getElementById(numId), fillEl = document.getElementById(fillId);
  numEl.textContent = seconds; numEl.classList.remove('urgent');
  fillEl.style.width = '100%'; fillEl.classList.remove('urgent');
  bonusTimerInterval = setInterval(() => {
    const rem = Math.max(0, seconds - (performance.now() - start) / 1000);
    numEl.textContent = seconds >= 10 ? Math.ceil(rem) : rem.toFixed(1);
    fillEl.style.width = (rem / seconds * 100) + '%';
    const urgent = rem <= seconds * 0.2;
    numEl.classList.toggle('urgent', urgent);
    fillEl.classList.toggle('urgent', urgent);
    if (rem <= 0) { clearInterval(bonusTimerInterval); onExpire(); }
  }, 100);
}
function stopBonusTimer(){ clearInterval(bonusTimerInterval); bonusTimerInterval = null; }

function resolveBonus(success, message){
  const fb = document.getElementById('bonusFeedback');
  fb.textContent = message + (success ? ' You win the point back.' : ' No point recovered this time.');
  fb.className = 'feedback ' + (success ? 'right' : 'wrong');
  if (success) score = Math.min(round.plan.length, score + 1);
  document.getElementById('bonusContinueBtn').style.display = '';
}

/* ── Countdown-style: combine the numbers to reach the target ── */
function bcRebuildTiles(){
  document.getElementById('bcTiles').innerHTML = bcNumbers.map((n, i) =>
    `<div class="num-tile${[25,50,75,100].includes(n) ? ' large-num' : ''}${bcUsed.has(i) ? ' used' : ''}" data-i="${i}">${n}</div>`
  ).join('');
  document.getElementById('bcTiles').querySelectorAll('.num-tile').forEach(el => {
    el.addEventListener('click', () => bcAddNumber(Number(el.textContent), Number(el.dataset.i)));
  });
}
function bcUpdateDisplay(){ document.getElementById('bcCalcDisplay').textContent = bcExpr || 'Select a number to begin…'; }
function startBonusCountdown(){
  bcNumbers = round.bonus.numbers.slice(); bcUsed = new Set(); bcExpr = ''; bcResult = null;
  document.getElementById('bcTarget').textContent = round.bonus.target;
  document.getElementById('bcSubmitBtn').disabled = true;
  bcRebuildTiles(); bcUpdateDisplay();
  startBonusTimer(30, () => finishBonusCountdown(bcResult), 'bcTimerNum', 'bcTimerFill');
}
function bcAddNumber(n, i){ if (bcUsed.has(i)) return; bcUsed.add(i); bcExpr += n; bcRebuildTiles(); bcUpdateDisplay(); }
function bcAddOp(op){ const last = bcExpr.slice(-1); if (bcExpr === '' || ['+','-','×','÷'].includes(last)) return; bcExpr += ' ' + op + ' '; bcUpdateDisplay(); }
function bcClear(){ bcExpr = ''; bcUsed = new Set(); bcResult = null; document.getElementById('bcSubmitBtn').disabled = true; bcRebuildTiles(); bcUpdateDisplay(); }
function bcBackspace(){
  bcExpr = bcExpr.trimEnd(); const parts = bcExpr.split(' '); parts.pop(); bcExpr = parts.join(' '); bcUpdateDisplay();
  bcUsed = new Set(); const avail = [...bcNumbers];
  (bcExpr.match(/\d+/g) || []).forEach(ns => { const idx = avail.indexOf(parseInt(ns,10)); if (idx !== -1) { bcUsed.add(idx); avail[idx] = null; } });
  bcRebuildTiles();
}
function bcEvaluate(){
  if (!bcExpr.trim()) return;
  const last = bcExpr.trim().slice(-1);
  if (['+','-','×','÷'].includes(last)) return;
  try {
    const safe = bcExpr.replace(/×/g,'*').replace(/÷/g,'/');
    const result = Function('"use strict"; return (' + safe + ')')();
    if (!Number.isFinite(result)) return;
    bcResult = result; bcExpr = bcExpr + ' = ' + result; bcUpdateDisplay();
    document.getElementById('bcSubmitBtn').disabled = false;
  } catch (e) {}
}
function bcSubmit(){ if (bcResult === null) return; document.getElementById('bcSubmitBtn').disabled = true; finishBonusCountdown(bcResult); }
function finishBonusCountdown(result){
  stopBonusTimer();
  document.getElementById('bcSubmitBtn').disabled = true;
  if (result === null) { resolveBonus(false, "Time's up — no answer submitted."); return; }
  const diff = Math.abs(result - round.bonus.target);
  resolveBonus(diff <= 10, `${result} — off by ${diff}.`);
}

document.getElementById('bcOpPlus').addEventListener('click', () => bcAddOp('+'));
document.getElementById('bcOpMinus').addEventListener('click', () => bcAddOp('-'));
document.getElementById('bcOpTimes').addEventListener('click', () => bcAddOp('×'));
document.getElementById('bcOpDivide').addEventListener('click', () => bcAddOp('÷'));
document.getElementById('bcClearBtn').addEventListener('click', bcClear);
document.getElementById('bcBackBtn').addEventListener('click', bcBackspace);
document.getElementById('bcEqualsBtn').addEventListener('click', bcEvaluate);
document.getElementById('bcSubmitBtn').addEventListener('click', bcSubmit);
document.getElementById('bonusContinueBtn').addEventListener('click', showResults);

function showResults(){
  const seconds = stopTimer();
  playView.style.display = 'none';
  bonusView.style.display = 'none';
  resultView.style.display = '';
  const finalScore = score;
  scoreBig.textContent = score + ' / ' + round.plan.length;
  bonusLine.style.display = 'block';
  bonusLine.textContent = `Finished in ${fmtTime(seconds)}.`;
  const msgs = ['Have another crack next week!','A solid effort.','Nice work.','Great round!','Weekly Trivia champions!'];
  const bracket = Math.min(Math.floor(score / round.plan.length * msgs.length), msgs.length - 1);
  scoreSub.textContent = msgs[bracket];
  window._lastResult = { group: fullGroupName(), house: selectedHouse || 'Staff', score: finalScore };
  if (selectedGroup !== 'Staff') {
    const g = fullGroupName();
    const played = readPlayedList();
    if (!played.includes(g)) { played.push(g); writePlayedList(played); }
  }
  document.getElementById('submitScoreBtn').textContent = 'Submit score to leaderboard';
  document.getElementById('submitScoreBtn').disabled = false;
  document.getElementById('submitConfirm').style.display = 'none';
}

function startRound(){
  round = currentWeekRound();
  weekTag.textContent = 'Term ' + round.term + ' · Week ' + round.weekInTerm;
  stage = 0; score = 0;
  playView.style.display = '';
  bonusView.style.display = 'none';
  resultView.style.display = 'none';
  bonusLine.style.display = 'none';
  startTimer();
  renderStage();
}

/* ── SIGN IN (house / home group, one attempt per group per week — same
   pattern as the rest of the suite, reusing Crack the Code's lock logic
   verbatim since this round replaces it) ── */
const HOUSES = ['Bunar','Dibbil','Kabul','Moori','Pirri','Yarraman'];
const GROUPS = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','Staff'];
let selectedHouse = null, selectedGroup = null;
function fullGroupName(){ if(!selectedGroup) return ''; return selectedGroup === 'Staff' ? 'Staff' : ((selectedHouse||'') + ' ' + selectedGroup).trim(); }
function normaliseGroupName(group){ return String(group||'').trim().replace(/\s+/g,' '); }
function isStaffGroup(group){ const g = normaliseGroupName(group); return g === 'Staff' || g.endsWith(' Staff'); }
function weekLabel(){ const r = currentWeekRound(); return 'Term ' + r.term + ' · Week ' + r.weekInTerm; }
function getPlayedKey(){ return 'trivia:played:' + weekLabel(); }
function readPlayedList(){ try{ const d = JSON.parse(localStorage.getItem(getPlayedKey())||'[]'); return Array.isArray(d)?d:[]; }catch(e){ return []; } }
function writePlayedList(d){ try{ localStorage.setItem(getPlayedKey(), JSON.stringify([...new Set(d.map(normaliseGroupName))])); }catch(e){} }
function isPlayed(group){ const g = normaliseGroupName(group); if(!g||isStaffGroup(g)) return false; return readPlayedList().includes(g); }

const lockNotice = document.getElementById('lockNotice'), startBtn = document.getElementById('startBtn'),
  weekTagSignin = document.getElementById('weekTagSignin'), signinCard = document.getElementById('signinCard'),
  playCard = document.getElementById('playCard');

function selectHouse(h){
  selectedHouse = h; selectedGroup = null;
  document.querySelectorAll('#houseSelectBtns .group-btn').forEach(b => b.classList.toggle('selected', b.textContent === h));
  document.querySelectorAll('#groupSelectBtns .group-btn').forEach(b => { b.disabled = false; b.removeAttribute('title'); b.classList.remove('selected'); });
  checkSignin();
}
function selectGroup(g){
  if(!selectedHouse) return;
  selectedGroup = g;
  document.querySelectorAll('#groupSelectBtns .group-btn').forEach(b => b.classList.toggle('selected', b.textContent === g));
  checkSignin();
}
function checkSignin(){
  const full = fullGroupName();
  if (full && isPlayed(full)) {
    lockNotice.textContent = full + ' has already played Weekly Trivia on this browser for ' + weekLabel() + '. Choose Staff to practise, or come back next week.';
    lockNotice.classList.add('show');
    startBtn.disabled = true;
    return;
  }
  lockNotice.classList.remove('show');
  startBtn.disabled = !(selectedHouse && selectedGroup);
}
function buildSignin(){
  weekTagSignin.textContent = weekLabel();
  document.getElementById('houseSelectBtns').innerHTML = HOUSES.map(h => `<button type="button" class="group-btn" onclick="selectHouse('${h}')">${h}</button>`).join('');
  document.getElementById('groupSelectBtns').innerHTML = GROUPS.map(g => `<button type="button" class="group-btn" onclick="selectGroup('${g}')" ${selectedHouse ? '' : 'disabled title="Choose a house first"'}>${g}</button>`).join('');
}
function resetToSignin(){
  selectedHouse = null; selectedGroup = null;
  playCard.style.display = 'none';
  signinCard.style.display = '';
  buildSignin();
  checkSignin();
}
startBtn.addEventListener('click', () => {
  if (!(selectedHouse && selectedGroup)) return;
  signinCard.style.display = 'none';
  playCard.style.display = '';
  startRound();
});

/* ── SUBMIT (shared Microsoft Form used by every Home Group game) ── */
function cshsSubmitButton(){ return document.getElementById('submitScoreBtn'); }
function cshsOpenForm(url){
  // URLSearchParams encodes spaces as "+", which Microsoft Forms stores
  // literally ("Moori+G"). A real plus is encoded as %2B, so every bare "+"
  // here is a space.
  url = String(url).replace(/\+/g, '%20');
  var w=null;
  try{ w=window.open(url,'_blank'); }catch(e){ w=null; }
  var box=document.getElementById('cshsFormFallback');
  if(w){
    if(box){ box.style.display='none'; }
    var btn0=cshsSubmitButton();
    var was=btn0?{text:btn0.textContent, disabled:btn0.disabled, animation:btn0.style.animation,
                  opacity:btn0.style.opacity, cursor:btn0.style.cursor}:null;
    setTimeout(function(){
      var btn=cshsSubmitButton();
      if(!btn||!was){ return; }
      btn.disabled=true;
      btn.textContent='✓ Score sent — press Submit in the form tab';
      btn.style.animation='none';
      btn.style.opacity='0.6';
      btn.style.cursor='default';
      var watch=setInterval(function(){
        if(!document.body.contains(btn)){ clearInterval(watch); return; }
        if(btn.offsetParent===null){
          btn.disabled=was.disabled;
          btn.textContent=was.text;
          btn.style.animation=was.animation;
          btn.style.opacity=was.opacity;
          btn.style.cursor=was.cursor;
          clearInterval(watch);
        }
      },300);
    },0);
    return true;
  }
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
      var anchor=cshsSubmitButton();
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

function submitScoreWT(){
  const r = window._lastResult;
  if (!r) return;
  const params = new URLSearchParams({
    id: CSHS_FORM_ID,
    [CSHS_F_WEEK]: weekLabel(),
    [CSHS_F_GAME]: 'Weekly Trivia',
    [CSHS_F_HOUSE]: r.house,
    [CSHS_F_GROUP]: r.group,
    [CSHS_F_SCORE]: String(r.score)
  });
  cshsOpenForm(CSHS_FORM_BASE + '?' + params.toString());
  document.getElementById('submitConfirm').style.display = 'block';
  document.getElementById('submitScoreBtn').textContent = '↗ Reopen form';
  document.getElementById('submitScoreBtn').disabled = false;
}

nextBtn.addEventListener('click', nextRound);
document.getElementById('submitScoreBtn').addEventListener('click', submitScoreWT);
document.getElementById('playAgainBtn').addEventListener('click', resetToSignin);
document.getElementById('backBtn').addEventListener('click', () => {
  window.location.href = (window.CSHS_SITE_CONFIG && window.CSHS_SITE_CONFIG.gamesHubUrl) || '../index.html';
});

buildSignin();
checkSignin();
</script>
</body>
</html>
