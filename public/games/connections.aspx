<%@ Page ContentType="text/html" ResponseEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-Frame-Options" content="ALLOWALL">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Connections Practice — CSHS</title>
<style>
  @import url('https://fonts.googleapis.com/css2?family=Bebas+Neue&family=DM+Sans:wght@400;500;600;700&family=DM+Mono:wght@500&display=swap');
  :root {
    --green:#00180f; --green-mid:#003d1f; --green-light:#005a2e;
    --gold:#f2b400; --gold-dim:rgba(242,180,0,0.15); --gold-border:rgba(242,180,0,0.3);
    --white:#fdfdfd; --muted:rgba(255,255,255,0.55); --danger:#e05252; --correct:#4caf7a;
    --cat0:#f2b400; --cat1:#4caf7a; --cat2:#5b9bd5; --cat3:#e05252;
  }
  *{box-sizing:border-box;margin:0;padding:0;}
  body{font-family:'DM Sans',sans-serif;background:var(--green);color:var(--white);min-height:100vh;overflow-x:hidden;}
  body::before{content:'';position:fixed;inset:0;background:radial-gradient(ellipse 80% 50% at 20% 0%,rgba(0,90,46,0.4) 0%,transparent 60%),radial-gradient(ellipse 60% 40% at 80% 100%,rgba(242,180,0,0.08) 0%,transparent 60%);pointer-events:none;z-index:0;}
  .container{max-width:680px;margin:0 auto;padding:24px 16px;position:relative;z-index:1;}
  .header{text-align:center;margin-bottom:24px;}
  .header-eyebrow{font-family:'DM Mono',monospace;font-size:10px;letter-spacing:0.2em;color:var(--gold);text-transform:uppercase;margin-bottom:8px;}
  .header h1{font-family:'Bebas Neue',sans-serif;font-size:clamp(52px,12vw,96px);color:var(--white);letter-spacing:0.05em;line-height:0.9;}
  .header h1 span{color:var(--gold);}
  .header-sub{font-size:13px;color:var(--muted);margin-top:8px;}
  .tabs{display:flex;gap:4px;margin-bottom:20px;background:rgba(255,255,255,0.04);border-radius:10px;padding:4px;}
  .tab{flex:1;padding:8px 12px;border-radius:7px;font-size:13px;font-weight:600;cursor:pointer;text-align:center;transition:all 0.15s;color:var(--muted);border:none;background:transparent;}
  .tab.active{background:var(--gold);color:var(--green);}
  .section{display:none;} .section.active{display:block;}
  .card{background:rgba(255,255,255,0.04);border:1px solid rgba(255,255,255,0.08);border-radius:16px;padding:24px;margin-bottom:20px;}
  .card-title{font-family:'DM Mono',monospace;font-size:10px;letter-spacing:0.18em;text-transform:uppercase;color:var(--gold);margin-bottom:16px;}
  .group-select{display:grid;grid-template-columns:repeat(auto-fill,minmax(100px,1fr));gap:8px;margin-bottom:8px;}
  .group-btn{background:var(--gold-dim);border:1px solid var(--gold-border);color:var(--white);padding:10px 8px;border-radius:10px;font-family:'DM Sans',sans-serif;font-size:13px;font-weight:600;cursor:pointer;transition:all 0.15s;text-align:center;}
  .group-btn:hover{background:rgba(242,180,0,0.28);border-color:var(--gold);}
  .group-btn.selected{background:var(--gold);color:var(--green);border-color:var(--gold);}
  .btn{display:inline-flex;align-items:center;justify-content:center;gap:8px;padding:12px 24px;border-radius:10px;font-family:'DM Sans',sans-serif;font-size:14px;font-weight:700;cursor:pointer;border:none;transition:all 0.15s;letter-spacing:0.02em;}
  .btn-primary{background:var(--gold);color:var(--green);}
  .btn-primary:hover{background:#ffc820;transform:translateY(-1px);box-shadow:0 4px 16px rgba(242,180,0,0.3);}
  .btn-primary:disabled{opacity:0.4;cursor:not-allowed;transform:none;box-shadow:none;}
  .btn-outline{background:transparent;color:var(--gold);border:1px solid var(--gold-border);}
  .btn-outline:hover{background:var(--gold-dim);}
  .btn-danger{background:transparent;color:var(--danger);border:1px solid rgba(224,82,82,0.3);font-size:12px;padding:8px 14px;}
  .full-width{width:100%;}
  /* Connections grid */
  .connections-grid{display:grid;grid-template-columns:repeat(4,1fr);gap:8px;margin:16px 0;}
  .conn-tile{padding:14px 8px;border-radius:10px;background:rgba(255,255,255,0.08);border:2px solid transparent;font-size:13px;font-weight:700;text-align:center;cursor:pointer;transition:all 0.2s;user-select:none;min-height:64px;display:flex;align-items:center;justify-content:center;line-height:1.2;}
  .conn-tile:hover{background:rgba(255,255,255,0.14);}
  .conn-tile.selected{background:rgba(242,180,0,0.25);border-color:var(--gold);color:var(--gold);}
  .conn-tile.solved{cursor:default;opacity:1;}
  .conn-tile.wrong{animation:shake 0.4s ease;}
  .conn-tile.cat0{background:rgba(242,180,0,0.2);border-color:var(--cat0);color:var(--cat0);}
  .conn-tile.cat1{background:rgba(76,175,122,0.2);border-color:var(--cat1);color:var(--cat1);}
  .conn-tile.cat2{background:rgba(91,155,213,0.2);border-color:var(--cat2);color:var(--cat2);}
  .conn-tile.cat3{background:rgba(224,82,82,0.2);border-color:var(--cat3);color:var(--cat3);}
  @keyframes shake{0%,100%{transform:translateX(0)}20%{transform:translateX(-6px)}40%{transform:translateX(6px)}60%{transform:translateX(-4px)}80%{transform:translateX(4px)}}
  /* Solved row */
  .solved-row{border-radius:10px;padding:14px 16px;margin-bottom:8px;text-align:center;}
  .solved-row-label{font-size:10px;letter-spacing:0.15em;text-transform:uppercase;font-family:'DM Mono',monospace;opacity:0.8;margin-bottom:4px;}
  .solved-row-words{font-size:13px;font-weight:600;}
  /* Lives */
  .lives{display:flex;gap:8px;justify-content:center;margin:12px 0;}
  .life{width:12px;height:12px;border-radius:50%;background:var(--gold);}
  .life.lost{background:rgba(255,255,255,0.15);}
  /* Attempts counter */
  .attempts-info{text-align:center;font-size:12px;color:var(--muted);margin-bottom:8px;}
  /* Score */
  .score-big{font-family:'Bebas Neue',sans-serif;font-size:80px;color:var(--gold);line-height:1;text-align:center;}
  .score-label{font-size:13px;color:var(--muted);text-align:center;margin-top:4px;}
  /* Week chip */
  .week-info{display:flex;align-items:center;gap:8px;flex-wrap:wrap;}
  .week-chip{background:var(--gold-dim);border:1px solid var(--gold-border);border-radius:20px;padding:4px 12px;font-size:12px;color:var(--gold);font-weight:600;}
  /* Admin */
  .admin-panel{display:none;} .admin-panel.open{display:block;}
  .admin-field{margin-bottom:14px;}
  .admin-field label{display:block;font-size:11px;color:var(--muted);margin-bottom:6px;text-transform:uppercase;letter-spacing:0.1em;}
  .admin-input{width:100%;background:rgba(255,255,255,0.06);border:1px solid rgba(255,255,255,0.15);border-radius:8px;padding:10px 12px;color:var(--white);font-family:'DM Sans',sans-serif;font-size:14px;}
  .admin-input:focus{outline:none;border-color:var(--gold);}
  .cat-block{border:1px solid rgba(255,255,255,0.1);border-radius:10px;padding:14px;margin-bottom:12px;}
  .cat-colour{width:12px;height:12px;border-radius:50%;display:inline-block;margin-right:6px;vertical-align:middle;}
  .flex-between{display:flex;align-items:center;justify-content:space-between;flex-wrap:wrap;gap:8px;}
  .mt16{margin-top:16px;}
  .toast{position:fixed;top:24px;left:50%;transform:translateX(-50%) translateY(-80px);background:var(--white);color:var(--green);padding:10px 20px;border-radius:8px;font-weight:700;font-size:14px;z-index:100;transition:transform 0.3s ease;pointer-events:none;}
  .toast.show{transform:translateX(-50%) translateY(0);}
  @media(max-width:480px){.connections-grid{grid-template-columns:repeat(2,1fr);} .conn-tile{min-height:56px;font-size:12px;}}
</style>
</head>
<body>
<div class="toast" id="toast"></div>
<div class="container">
  <div class="header">
    <div class="header-eyebrow">Corinda State High School · Practice Mode</div>
    <h1>CONNEC<span>TIONS</span></h1>
    <div class="header-sub">Unlimited practice — a fresh puzzle every round, not the leaderboard puzzle</div>
  </div>

  <div class="tabs">
    <button class="tab active" onclick="switchTab('game')">Game</button>
  </div>

  <!-- GAME TAB -->
  <div id="tab-game" class="section active">

    <!-- Play -->
    <div id="screen-signin" class="section active">
      <div class="card">
        <div class="card-title">Practice Mode</div>
        <p style="font-size:14px;color:var(--muted);line-height:1.6;margin-bottom:16px;">Play as many rounds as you like. Every round uses a fresh puzzle — never this week's official Home Group puzzle — and nothing is submitted to the leaderboard.</p>
        <button class="btn btn-primary full-width" id="startBtn" onclick="startGame()">Start Practice Round</button>
      </div>
      <div class="card">
        <div class="card-title">Practice details</div>
        <div class="week-info" id="weekInfo"></div>
      </div>
    </div>

    <!-- Playing -->
    <div id="screen-playing" class="section">
      <div class="card">
        <div class="flex-between" style="margin-bottom:16px;">
          <div class="card-title" style="margin-bottom:2px;">Practice Round</div>
          <div id="livesDisplay" class="lives"></div>
        </div>
        <div id="solvedRows"></div>
        <div class="connections-grid" id="connectionsGrid"></div>
        <div class="attempts-info" id="attemptsInfo"></div>
        <div style="display:flex;gap:8px;margin-top:12px;">
          <button class="btn btn-outline" style="flex:1;" onclick="deselectAll()">Deselect All</button>
          <button class="btn btn-primary" style="flex:1;" id="submitGuessBtn" onclick="submitGuess()" disabled>Submit</button>
        </div>
        <div id="oneAwayMsg" style="display:none;text-align:center;font-size:12px;color:var(--gold);margin-top:8px;">One away!</div>
      </div>
    </div>

    <!-- Result -->
    <div id="screen-result" class="section">
      <div class="card">
        <div class="card-title">Round complete</div>
        <div style="padding:16px 0 8px;">
          <div style="font-size:36px;text-align:center;margin-bottom:8px;" id="resultEmoji">🎉</div>
          <div class="score-big" id="finalScore">0</div>
          <div class="score-label" id="scoreLabelText">points</div>
          <div style="font-size:15px;font-weight:700;color:var(--gold);margin-top:6px;" id="resultBreakdownLine"></div>
        </div>
        <div id="resultSummary" style="margin:12px 0;display:flex;flex-direction:column;gap:6px;"></div>
        <div style="display:flex;flex-direction:column;gap:10px;margin-top:16px;">
          <button class="btn btn-primary full-width" onclick="startGame()" style="font-size:16px;padding:14px;">🔁 Play Again</button>
          <button class="btn btn-outline full-width" onclick="resetToSignin()">← Back to practice menu</button>
        </div>
      </div>
    </div>

  </div>

  <!-- ADMIN TAB -->
  

</div>

<script src="../../assets/site-config.js"></script>
<script>
const CAT_COLOURS = ['cat0','cat1','cat2','cat3'];
const CAT_LABELS = ['Easy','Medium','Hard','Tricky'];

let config = { categories: [] };


const PUZZLE_BANK = [
  // T1 W1 — Welcome back
  { categories: [
    { name: 'Words meaning a fresh start', words: ['Reset', 'Renewal', 'Relaunch', 'Reboot'] },
    { name: 'Things in a kitchen', words: ['Whisk', 'Colander', 'Spatula', 'Ladle'] },
    { name: 'Australian animals', words: ['Quokka', 'Numbat', 'Bilby', 'Dugong'] },
    { name: '___ ball', words: ['Basket', 'Cannon', 'Snow', 'Odd'] }
  ]},
  // T1 W2 — Positive Education intro
  { categories: [
    { name: 'PERMAH pillars', words: ['Positive emotion', 'Engagement', 'Relationships', 'Meaning'] },
    { name: 'Things that are black and white', words: ['Zebra', 'Panda', 'Magpie', 'Piano'] },
    { name: 'Olympic sports', words: ['Fencing', 'Luge', 'Heptathlon', 'Dressage'] },
    { name: '___ fish', words: ['Sword', 'Star', 'Cat', 'Blow'] }
  ]},
  // T1 W3 — PERMAH overview
  { categories: [
    { name: 'Things that build positive emotion', words: ['Gratitude', 'Laughter', 'Savouring', 'Celebration'] },
    { name: 'Parts of a cell', words: ['Nucleus', 'Mitochondria', 'Ribosome', 'Vacuole'] },
    { name: 'Types of pasta', words: ['Penne', 'Fusilli', 'Rigatoni', 'Orzo'] },
    { name: '___ light', words: ['Sun', 'Moon', 'Torch', 'Flash'] }
  ]},
  // T1 W4 — Virtues & character strengths
  { categories: [
    { name: 'Wisdom strengths', words: ['Curiosity', 'Creativity', 'Judgement', 'Perspective'] },
    { name: 'Things with rings', words: ['Saturn', 'Olympics', 'Gymnastics', 'Boxing'] },
    { name: 'Dances', words: ['Tango', 'Foxtrot', 'Waltz', 'Quickstep'] },
    { name: '___ house', words: ['Green', 'Power', 'Tree', 'Full'] }
  ]},
  // T1 W5 — Virtue of Humanity
  { categories: [
    { name: 'Ways humanity can be shown', words: ['Love', 'Kindness', 'Social intelligence', 'Empathy'] },
    { name: 'Bones in the human body', words: ['Femur', 'Clavicle', 'Patella', 'Tibia'] },
    { name: 'Types of triangle', words: ['Scalene', 'Isosceles', 'Equilateral', 'Obtuse'] },
    { name: '___ bridge', words: ['Cam', 'Draw', 'Foot', 'Stone'] }
  ]},
  // T1 W6 — Love
  { categories: [
    { name: 'Words meaning love', words: ['Adore', 'Cherish', 'Treasure', 'Devotion'] },
    { name: 'Types of music', words: ['Bluegrass', 'Grime', 'Bossa nova', 'Ska'] },
    { name: 'Things that can be raw', words: ['Deal', 'Talent', 'Sewage', 'Egg'] },
    { name: '___ stone', words: ['Lime', 'Sand', 'Cobble', 'Kerb'] }
  ]},
  // T1 W7 — Social Intelligence
  { categories: [
    { name: 'Ways to read the room', words: ['Body language', 'Tone of voice', 'Eye contact', 'Silence'] },
    { name: 'Planets in order from the Sun', words: ['Mercury', 'Venus', 'Earth', 'Mars'] },
    { name: 'Australians named Chris', words: ['Hemsworth', 'Judd', 'Lilley', 'Lynn'] },
    { name: 'Things with a shell', words: ['Tortoise', 'Walnut', 'Egg', 'Snail'] }
  ]},
  // T1 W8 — Kindness
  { categories: [
    { name: 'Random acts of kindness', words: ['Hold the door', 'Write a note', 'Share lunch', 'Give a compliment'] },
    { name: 'Things that rise', words: ['Dough', 'Sun', 'Tide', 'Smoke'] },
    { name: 'Collective nouns', words: ['Murder', 'Bloat', 'Parliament', 'Crash'] },
    { name: 'Brisbane landmarks', words: ['Story Bridge', 'South Bank', 'GOMA', 'Eagle Street'] }
  ]},
  // T1 W9 — Virtue of Transcendence
  { categories: [
    { name: 'Transcendence strengths', words: ['Gratitude', 'Hope', 'Humour', 'Spirituality'] },
    { name: 'Types of energy', words: ['Kinetic', 'Thermal', 'Nuclear', 'Elastic'] },
    { name: 'Famous scientists', words: ['Curie', 'Faraday', 'Turing', 'Lovelace'] },
    { name: '___ wave', words: ['Heat', 'Crime', 'Tidal', 'Micro'] }
  ]},
  // T1 W10 — Humour
  { categories: [
    { name: 'Types of humour', words: ['Satire', 'Slapstick', 'Irony', 'Wit'] },
    { name: 'Things in a rainforest', words: ['Canopy', 'Epiphyte', 'Termite', 'Bromeliad'] },
    { name: 'Sports played on a court', words: ['Squash', 'Netball', 'Volleyball', 'Badminton'] },
    { name: '___ fall', words: ['Water', 'Down', 'Free', 'Foot'] }
  ]},
  // T2 W1 — Spirituality / Meaning
  { categories: [
    { name: 'Words meaning inner peace', words: ['Serenity', 'Calm', 'Stillness', 'Tranquility'] },
    { name: 'Things that can be cold', words: ['Shoulder', 'Turkey', 'Blooded', 'Case'] },
    { name: 'Animals that lay eggs', words: ['Platypus', 'Echidna', 'Chicken', 'Octopus'] },
    { name: '___ run', words: ['Bull', 'Home', 'Dry', 'Fun'] }
  ]},
  // T2 W2 — Appreciation of beauty
  { categories: [
    { name: 'Things considered beautiful in nature', words: ['Sunset', 'Aurora', 'Coral reef', 'Rainforest'] },
    { name: 'Famous paintings', words: ['Starry Night', 'The Scream', 'Guernica', 'Nighthawks'] },
    { name: 'Things with a trunk', words: ['Elephant', 'Car', 'Tree', 'Swimmer'] },
    { name: '___ bank', words: ['River', 'Food', 'Blood', 'Memory'] }
  ]},
  // T2 W3 — Hope
  { categories: [
    { name: 'Famous symbols of hope', words: ['Dove', 'Rainbow', 'Candle', 'Anchor'] },
    { name: 'Parts of a plant', words: ['Stigma', 'Anther', 'Sepal', 'Petiole'] },
    { name: 'Things that can be broken', words: ['Record', 'Promise', 'Silence', 'Ice'] },
    { name: '___ pool', words: ['Car', 'Dead', 'Rock', 'Gene'] }
  ]},
  // T2 W4 — Gratitude
  { categories: [
    { name: 'Ways to show gratitude', words: ['Thank-you note', 'Acknowledgement', 'Compliment', 'Hug'] },
    { name: 'Things with keys', words: ['Piano', 'Lock', 'Map', 'Cipher'] },
    { name: 'Words for a group of people', words: ['Cohort', 'Posse', 'Rabble', 'Troupe'] },
    { name: 'Australian birds', words: ['Kookaburra', 'Boobook', 'Cassowary', 'Brolga'] }
  ]},
  // T2 W5 — Virtue of Wisdom
  { categories: [
    { name: 'Wisdom strengths', words: ['Curiosity', 'Creativity', 'Judgement', 'Perspective'] },
    { name: 'Things with a mouth', words: ['River', 'Cave', 'Jar', 'Volcano'] },
    { name: 'Types of cheese', words: ['Gruyere', 'Manchego', 'Haloumi', 'Brie'] },
    { name: '___ work', words: ['Team', 'Net', 'Frame', 'Ground'] }
  ]},
  // T2 W6 — Love of Learning
  { categories: [
    { name: 'Famous learners who changed the world', words: ['Einstein', 'Curie', 'Da Vinci', 'Turing'] },
    { name: 'Things that can be sharp', words: ['Mind', 'Knife', 'Turn', 'Tongue'] },
    { name: 'Famous Queensland sportspeople', words: ['Ash Barty', 'Pat Rafter', 'Jai Arrow', 'Kalyn Ponga'] },
    { name: '___ star', words: ['Gold', 'Rock', 'Pop', 'All'] }
  ]},
  // T2 W7 — Perspective
  { categories: [
    { name: 'Words meaning a point of view', words: ['Standpoint', 'Outlook', 'Lens', 'Angle'] },
    { name: 'Things you can catch', words: ['Bus', 'Cold', 'Fish', 'Break'] },
    { name: 'Types of map', words: ['Topographic', 'Choropleth', 'Mercator', 'Isoline'] },
    { name: '___ force', words: ['Air', 'Task', 'Work', 'Brute'] }
  ]},
  // T2 W8 — Curiosity
  { categories: [
    { name: 'Things curious people do', words: ['Question', 'Explore', 'Experiment', 'Wonder'] },
    { name: 'Things with a point', words: ['Compass', 'Argument', 'Pencil', 'Needle'] },
    { name: 'Things that are recycled', words: ['Glass', 'Paper', 'Aluminium', 'Plastic'] },
    { name: '___ change', words: ['Climate', 'Sea', 'Free', 'Pocket'] }
  ]},
  // T2 W9 — Creativity
  { categories: [
    { name: 'Words meaning original or inventive', words: ['Innovative', 'Imaginative', 'Inventive', 'Novel'] },
    { name: 'Things that can be stacked', words: ['Pancakes', 'Chips', 'Odds', 'Deck'] },
    { name: 'Elements on the periodic table', words: ['Cobalt', 'Neon', 'Tungsten', 'Iodine'] },
    { name: '___ room', words: ['Show', 'Boom', 'Mush', 'Chat'] }
  ]},
  // T2 W10 — Judgement
  { categories: [
    { name: 'Things that can cloud your judgement', words: ['Bias', 'Emotion', 'Pressure', 'Misinformation'] },
    { name: 'Things that flow', words: ['Lava', 'Traffic', 'Conversation', 'Current'] },
    { name: 'Parts of a school', words: ['Canteen', 'Oval', 'Library', 'Staffroom'] },
    { name: '___ time', words: ['Over', 'Bed', 'Half', 'Prime'] }
  ]},
  // T3 W1 — Virtues recap
  { categories: [
    { name: 'Courage strengths', words: ['Bravery', 'Perseverance', 'Honesty', 'Zest'] },
    { name: 'Things in a jungle', words: ['Canopy', 'Liana', 'Jaguar', 'Toucan'] },
    { name: 'Types of bridge', words: ['Suspension', 'Arch', 'Truss', 'Cable-stay'] },
    { name: 'Famous scientists', words: ['Curie', 'Darwin', 'Newton', 'Einstein'] }
  ]},
  // T3 W2 — PERMAH recap
  { categories: [
    { name: 'Things that build Relationships', words: ['Trust', 'Empathy', 'Time', 'Listening'] },
    { name: 'Things that are sticky', words: ['Honey', 'Tape', 'Glue', 'Sap'] },
    { name: 'Australian prime ministers', words: ['Whitlam', 'Hawke', 'Howard', 'Keating'] },
    { name: '___ ring', words: ['Boxing', 'Wedding', 'Ear', 'Key'] }
  ]},
  // T3 W3 — Virtue of Justice
  { categories: [
    { name: 'Justice strengths and civic action', words: ['Teamwork', 'Fairness', 'Leadership', 'Citizenship'] },
    { name: 'Things in a theatre', words: ['Wings', 'Backdrop', 'Footlights', 'Prompt'] },
    { name: 'Things that orbit Earth', words: ['Moon', 'ISS', 'Hubble', 'GPS satellite'] },
    { name: '___ dog', words: ['Hot', 'Corn', 'Bull', 'Grey'] }
  ]},
  // T3 W4 — Leadership
  { categories: [
    { name: 'Qualities of a good leader', words: ['Vision', 'Empathy', 'Decisiveness', 'Integrity'] },
    { name: 'Things that float', words: ['Cork', 'Iceberg', 'Raft', 'Balloon'] },
    { name: 'Dances', words: ['Salsa', 'Waltz', 'Foxtrot', 'Lindy'] },
    { name: 'Ancient wonders', words: ['Colossus', 'Lighthouse', 'Mausoleum', 'Pyramids'] }
  ]},
  // T3 W5 — Fairness
  { categories: [
    { name: 'Words meaning fairness', words: ['Equity', 'Justice', 'Impartiality', 'Balance'] },
    { name: 'Things with keys', words: ['Piano', 'Lock', 'Map', 'Computer'] },
    { name: 'Things found in a desert', words: ['Dune', 'Oasis', 'Mirage', 'Cactus'] },
    { name: '___ wave', words: ['Heat', 'Tidal', 'Crime', 'Brain'] }
  ]},
  // T3 W6 — Teamwork
  { categories: [
    { name: 'Things a great team has', words: ['Trust', 'Communication', 'Roles', 'Shared goals'] },
    { name: 'Things with shells', words: ['Snail', 'Tortoise', 'Oyster', 'Walnut'] },
    { name: 'Types of poetry', words: ['Haiku', 'Sonnet', 'Limerick', 'Ballad'] },
    { name: '___ park', words: ['Car', 'Theme', 'National', 'Skate'] }
  ]},
  // T3 W7 — Virtue of Courage
  { categories: [
    { name: 'Courage strengths', words: ['Bravery', 'Perseverance', 'Honesty', 'Zest'] },
    { name: 'Things in a hospital', words: ['Scalpel', 'Stethoscope', 'Ward', 'Gurney'] },
    { name: 'Famous explorers', words: ['Columbus', 'Magellan', 'Cook', 'Amundsen'] },
    { name: '___ fire', words: ['Camp', 'Cross', 'Open', 'Rapid'] }
  ]},
  // T3 W8 — Zest
  { categories: [
    { name: 'Words meaning enthusiasm', words: ['Gusto', 'Vigour', 'Verve', 'Passion'] },
    { name: 'Things with teeth', words: ['Comb', 'Saw', 'Zip', 'Gear'] },
    { name: 'Types of election', words: ['Federal', 'State', 'Local', 'By-election'] },
    { name: '___ house', words: ['Green', 'Ice', 'Warehouse', 'Fire'] }
  ]},
  // T3 W9 — Bravery
  { categories: [
    { name: 'Words meaning brave', words: ['Valiant', 'Daring', 'Gallant', 'Audacious'] },
    { name: 'Things that can be raw', words: ['Data', 'Talent', 'Egg', 'Deal'] },
    { name: 'Types of map', words: ['Topographic', 'Political', 'Climate', 'Road'] },
    { name: 'Things in a library', words: ['Catalogue', 'Stacks', 'Microfiche', 'Folio'] }
  ]},
  // T3 W10 — Perseverance
  { categories: [
    { name: 'Words meaning to keep going', words: ['Persist', 'Endure', 'Grind', 'Push through'] },
    { name: 'Things that are hollow', words: ['Flute', 'Cave', 'Bone', 'Log'] },
    { name: 'Forms or systems of government', words: ['Democracy', 'Republic', 'Monarchy', 'Federation'] },
    { name: '___ net', words: ['Hair', 'Safety', 'Fishing', 'Inter'] }
  ]},
  // T4 W1 — Honesty
  { categories: [
    { name: 'Words meaning honest', words: ['Truthful', 'Sincere', 'Frank', 'Candid'] },
    { name: 'Things that are layered', words: ['Cake', 'Sediment', 'Onion', 'Atmosphere'] },
    { name: 'Types of coffee', words: ['Espresso', 'Lungo', 'Ristretto', 'Macchiato'] },
    { name: '___ point', words: ['Gun', 'Needle', 'Ball', 'Flash'] }
  ]},
  // T4 W2 — Courage review
  { categories: [
    { name: 'All four Courage strengths', words: ['Bravery', 'Perseverance', 'Honesty', 'Zest'] },
    { name: 'Things that can be blind', words: ['Spot', 'Date', 'Test', 'Side'] },
    { name: 'Types of energy', words: ['Kinetic', 'Thermal', 'Nuclear', 'Solar'] },
    { name: 'Famous Australians in sport', words: ['Thorpe', 'Healy', 'Barty', 'Freeman'] }
  ]},
  // T4 W3 — Virtue of Temperance
  { categories: [
    { name: 'Temperance strengths', words: ['Forgiveness', 'Humility', 'Prudence', 'Self-regulation'] },
    { name: 'Things you can pitch', words: ['Tent', 'Ball', 'Idea', 'Voice'] },
    { name: 'Types of fabric', words: ['Denim', 'Linen', 'Velvet', 'Tweed'] },
    { name: 'Things in outer space', words: ['Nebula', 'Pulsar', 'Quasar', 'Comet'] }
  ]},
  // T4 W4 — Prudence
  { categories: [
    { name: 'Words meaning prudent', words: ['Cautious', 'Careful', 'Wise', 'Sensible'] },
    { name: 'Things that can be flat', words: ['Tyre', 'Battery', 'Earth', 'Rate'] },
    { name: 'Types of market', words: ['Stock', 'Farmers', 'Flea', 'Bull'] },
    { name: '___ field', words: ['Mine', 'Air', 'Corn', 'Battle'] }
  ]},
  // T4 W5 — Humility
  { categories: [
    { name: 'Words meaning humble', words: ['Modest', 'Grounded', 'Unpretentious', 'Unassuming'] },
    { name: 'Things with a crown', words: ['King', 'Tooth', 'Tree', 'Head'] },
    { name: '___ break', words: ['Lunch', 'Spring', 'Coffee', 'Study'] },
    { name: 'Things that can be viral', words: ['Video', 'Post', 'Trend', 'Meme'] }
  ]},
  // T4 W6 — Self-Regulation
  { categories: [
    { name: 'Ways to regulate your emotions', words: ['Deep breathing', 'Grounding', 'Journalling', 'Exercise'] },
    { name: 'Things that spin', words: ['Top', 'Turbine', 'Roulette', 'Gyroscope'] },
    { name: 'Types of humour', words: ['Satire', 'Irony', 'Slapstick', 'Parody'] },
    { name: '___ line', words: ['Finish', 'Base', 'Dead', 'Power'] }
  ]},
  // T4 W7 — Forgiveness
  { categories: [
    { name: 'Words meaning to forgive', words: ['Pardon', 'Absolve', 'Release', 'Let go'] },
    { name: 'Things that can be acute', words: ['Angle', 'Pain', 'Awareness', 'Shortage'] },
    { name: 'Types of font', words: ['Serif', 'Gothic', 'Italic', 'Monospace'] },
    { name: '___ run', words: ['Home', 'Dry', 'Bull', 'Ski'] }
  ]},
  // T4 W8 — Year in review
  { categories: [
    { name: 'Things to reflect on at year end', words: ['Growth', 'Challenges', 'Highlights', 'Gratitude'] },
    { name: 'Things that can be charged', words: ['Battery', 'Fee', 'Crime', 'Particle'] },
    { name: 'Types of soil', words: ['Loam', 'Clay', 'Sandy', 'Silt'] },
    { name: 'Things associated with endings', words: ['Sunset', 'Graduation', 'Finale', 'Credits'] }
  ]},
  // T4 W9 — Looking ahead
  { categories: [
    { name: 'Ways to begin a new goal', words: ['Plan', 'Practise', 'Ask for help', 'Start small'] },
    { name: 'Things people forecast', words: ['Weather', 'Demand', 'Sales', 'Trends'] },
    { name: '___ board', words: ['White', 'Surf', 'Skate', 'Notice'] },
    { name: 'Australian summer activities', words: ['Swimming', 'Cricket', 'Barbecue', 'Beach'] }
  ]},
  // T4 W10 — Celebrate and reset
  { categories: [
    { name: 'Ways to finish the year well', words: ['Celebrate', 'Thank others', 'Reflect', 'Rest'] },
    { name: 'Things that sparkle', words: ['Tinsel', 'Stars', 'Glitter', 'Sequins'] },
    { name: 'Places to spend a holiday', words: ['Beach', 'Mountains', 'City', 'Home'] },
    { name: '___ party', words: ['Birthday', 'Block', 'Pool', 'Dinner'] }
  ]}
];


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

// Auto week label, e.g. 'Term 2 · Week 7'
function cshsWeekLabel(){ const w=cshsCurrentWeek(); return `Term ${w.t} · Week ${w.w}`; }

// Week-seeded puzzle selection (now date-driven)
// Picks a random puzzle from the weekly bank, excluding the current live
// Home Group week's official puzzle so practice never gives away the answer.
function getPracticePuzzle() {
  const weekNum = cshsCurrentWeek().abs;
  const officialPuzzle = PUZZLE_BANK[(weekNum - 1) % PUZZLE_BANK.length];
  const pool = PUZZLE_BANK.filter(p => p !== officialPuzzle);
  return pool[Math.floor(Math.random() * pool.length)];
}

let selectedTiles = new Set(), solvedCategories = [], mistakes = 0, gameOver = false;
let gameStartTime = 0;
let shuffledWords = [];

// ─── INIT ─────────────────────────────────────────────────────────────────────
function init() {
  renderWeekPreview();
}

function renderWeekPreview() {
  document.getElementById('weekInfo').innerHTML = `
    <div class="week-chip">Unlimited practice</div>
    <div class="week-chip">New puzzle each round</div>
    <div class="week-chip">Max 10 pts</div>
  `;
}

// ─── GAME ─────────────────────────────────────────────────────────────────────
function startGame() {
  selectedTiles = new Set(); solvedCategories = []; mistakes = 0; gameOver = false;
  gameStartTime = Date.now();
  document.getElementById('solvedRows').innerHTML = '';
  document.getElementById('oneAwayMsg').style.display = 'none';

  // Get a fresh practice puzzle
  const puzzle = getPracticePuzzle();
  config.categories = puzzle.categories;

  // Shuffle all 16 words
  shuffledWords = config.categories.flatMap((cat, ci) =>
    cat.words.map(w => ({ word: w, catIndex: ci }))
  );
  for (let i = shuffledWords.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [shuffledWords[i], shuffledWords[j]] = [shuffledWords[j], shuffledWords[i]];
  }

  renderLives();
  renderGrid();
  updateAttemptsInfo();
  showScreen('screen-playing');
}

function renderLives() {
  const maxMistakes = 4;
  document.getElementById('livesDisplay').innerHTML =
    Array.from({ length: maxMistakes }, (_, i) =>
      `<div class="life ${i < mistakes ? 'lost' : ''}"></div>`
    ).join('');
}

function renderGrid() {
  const grid = document.getElementById('connectionsGrid');
  const unsolvedWords = shuffledWords.filter(w =>
    !solvedCategories.includes(w.catIndex)
  );
  grid.innerHTML = unsolvedWords.map(({ word, catIndex }) => `
    <div class="conn-tile ${selectedTiles.has(word) ? 'selected' : ''}"
      onclick="toggleTile('${word.replace(/'/g,"\\'")}')">
      ${word}
    </div>
  `).join('');
}

function toggleTile(word) {
  if (gameOver) return;
  if (selectedTiles.has(word)) {
    selectedTiles.delete(word);
  } else if (selectedTiles.size < 4) {
    selectedTiles.add(word);
  }
  document.getElementById('submitGuessBtn').disabled = selectedTiles.size !== 4;
  document.getElementById('oneAwayMsg').style.display = 'none';
  renderGrid();
}

function deselectAll() {
  selectedTiles = new Set();
  document.getElementById('submitGuessBtn').disabled = true;
  document.getElementById('oneAwayMsg').style.display = 'none';
  renderGrid();
}

function submitGuess() {
  if (selectedTiles.size !== 4 || gameOver) return;
  const selected = [...selectedTiles];

  // Check each category
  for (let ci = 0; ci < config.categories.length; ci++) {
    if (solvedCategories.includes(ci)) continue;
    const cat = config.categories[ci];
    const matches = selected.filter(w => cat.words.includes(w)).length;

    if (matches === 4) {
      // Correct!
      solvedCategories.push(ci);
      selectedTiles = new Set();
      document.getElementById('oneAwayMsg').style.display = 'none';
      // Add solved row
      const cat = config.categories[ci];
      const solvedRow = document.createElement('div');
      solvedRow.className = `solved-row ${CAT_COLOURS[cat.colour]}`;
      solvedRow.style.background = getCatBg(cat.colour);
      solvedRow.style.border = `1px solid ${getCatColour(cat.colour)}`;
      solvedRow.innerHTML = `
        <div class="solved-row-label">${cat.name}</div>
        <div class="solved-row-words">${cat.words.join(' · ')}</div>
      `;
      document.getElementById('solvedRows').appendChild(solvedRow);
      showToast('✓ Correct!');

      if (solvedCategories.length === 4) {
        endGame();
        return;
      }
      renderGrid();
      updateAttemptsInfo();
      document.getElementById('submitGuessBtn').disabled = true;
      return;
    }

    if (matches === 3) {
      document.getElementById('oneAwayMsg').style.display = 'block';
    }
  }

  // Wrong guess
  mistakes++;
  renderLives();
  updateAttemptsInfo();
  // Shake tiles
  document.querySelectorAll('.conn-tile.selected').forEach(t => {
    t.classList.add('wrong');
    setTimeout(() => t.classList.remove('wrong'), 400);
  });
  showToast('Not quite — try again!');

  if (mistakes >= 4) {
    endGame();
  }
}

function updateAttemptsInfo() {
  document.getElementById('attemptsInfo').textContent =
    `${solvedCategories.length} of 4 found · ${4 - mistakes} guesses remaining`;
}

function getCatBg(i) {
  return ['rgba(242,180,0,0.15)','rgba(76,175,122,0.15)','rgba(91,155,213,0.15)','rgba(224,82,82,0.15)'][i];
}
function getCatColour(i) {
  return ['rgba(242,180,0,0.5)','rgba(76,175,122,0.5)','rgba(91,155,213,0.5)','rgba(224,82,82,0.5)'][i];
}

function endGame() {
  gameOver = true;
  const solved = solvedCategories.length;
  const basePts = (solved * 25) + (mistakes === 0 && solved === 4 ? 25 : 0);
  const elapsedSecs = (Date.now() - gameStartTime) / 1000;
  const maxTimeSecs = 300;
  const timeBonus = solved === 4 ? Math.max(0, Math.round(25 * (1 - elapsedSecs / maxTimeSecs))) : 0;
  const won = solved === 4;
  // Smooth curve by mistakes: 0->10, 1->9, 2->8, 3->7, 4(but solved)->6.
  // Failed but had a go (made >=1 guess, right or wrong) -> 3. Nothing -> 0.
  function connScore(){
    if (won){
      return [10,9,8,7,6][Math.min(mistakes,4)];
    }
    const hadGo = (mistakes >= 1) || (solved >= 1);
    return hadGo ? 3 : 0;
  }
  const scaled = connScore();

  document.getElementById('resultEmoji').textContent = won ? (mistakes === 0 ? '🏆' : '🎉') : '🙂';
  document.getElementById('finalScore').textContent = scaled;
  document.getElementById('scoreLabelText').textContent = 'out of 10';

  // How the score was worked out
  const breakdownEl = document.getElementById('resultBreakdownLine');
  if (breakdownEl) {
    breakdownEl.textContent = won
      ? (mistakes === 0 ? 'Solved with no mistakes → top score!' : `Solved with ${mistakes} mistake${mistakes!==1?'s':''} → ${scaled} out of 10`)
      : (scaled === 3 ? `Found ${solved} of 4 groups → 3 out of 10 for having a go` : 'No guesses made → 0 out of 10');
  }

  // Result summary
  const summary = document.getElementById('resultSummary');
  summary.innerHTML = config.categories.map((cat, ci) => {
    const wasSolved = solvedCategories.includes(ci);
    return `<div style="padding:10px 14px;border-radius:8px;background:${getCatBg(cat.colour)};border:1px solid ${getCatColour(cat.colour)};">
      <div style="font-size:10px;text-transform:uppercase;letter-spacing:0.1em;color:rgba(255,255,255,0.6);margin-bottom:2px;">${cat.name}</div>
      <div style="font-size:12px;font-weight:600;color:${wasSolved?'var(--correct)':'var(--muted)'};">${wasSolved ? '✓ ' : '✗ '}${cat.words.join(', ')}</div>
    </div>`;
  }).join('');

  showScreen('screen-result');
}

// ─── SCREENS ──────────────────────────────────────────────────────────────────
function showScreen(id) {
  ['screen-signin','screen-playing','screen-result'].forEach(s =>
    document.getElementById(s).classList.toggle('active', s === id)
  );
}

function resetToSignin() {
  gameOver = false; selectedTiles = new Set();
  showScreen('screen-signin');
}

// ─── TABS ─────────────────────────────────────────────────────────────────────
function switchTab(name) {
  ['game','admin'].forEach(t => document.getElementById(`tab-${t}`).classList.toggle('active', t === name));
  document.querySelectorAll('.tab').forEach((btn, i) => btn.classList.toggle('active', ['game','admin'][i] === name));
}

// ─── ADMIN ────────────────────────────────────────────────────────────────────


// ─── TOAST ────────────────────────────────────────────────────────────────────
let toastTimer = null;
function showToast(msg) {
  const t = document.getElementById('toast');
  t.textContent = msg; t.classList.add('show');
  if (toastTimer) clearTimeout(toastTimer);
  toastTimer = setTimeout(() => t.classList.remove('show'), 2000);
}

init();

</script>
</body>
</html>
