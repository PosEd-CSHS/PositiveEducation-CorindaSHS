<%@ Page ContentType="text/html" ResponseEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Open Resources — Corinda SHS</title>
<style>
  @import url('../assets/fonts/fonts.css');

  :root {
    --green: #00180f;
    --green-mid: #003d1f;
    --green-light: #005a2e;
    --gold: #f2b400;
    --gold-dim: rgba(242,180,0,0.15);
    --gold-border: rgba(242,180,0,0.3);
    --white: #fdfdfd;
    --muted: rgba(255,255,255,0.6);
  }

  * { box-sizing: border-box; margin: 0; padding: 0; }

  body {
    font-family: 'DM Sans', sans-serif;
    background: var(--green);
    color: var(--white);
    min-height: 100vh;
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

  .wrap {
    max-width: 720px;
    margin: 0 auto;
    padding: 40px 20px 64px;
    position: relative;
    z-index: 1;
  }

  header { text-align: center; margin-bottom: 40px; }
  .eyebrow {
    font-family: 'DM Mono', monospace;
    font-size: 11px;
    letter-spacing: 0.12em;
    text-transform: uppercase;
    color: var(--gold);
    margin-bottom: 8px;
  }
  h1 {
    font-family: 'Bebas Neue', sans-serif;
    font-size: clamp(32px, 6vw, 52px);
    letter-spacing: 0.02em;
    line-height: 1.05;
  }
  .lede {
    max-width: 560px;
    margin: 14px auto 0;
    color: var(--muted);
    font-size: 15px;
    line-height: 1.55;
  }

  .note {
    max-width: 560px;
    margin: 18px auto 0;
    background: var(--gold-dim);
    border: 1px solid var(--gold-border);
    border-radius: 10px;
    padding: 12px 16px;
    font-size: 13px;
    color: var(--white);
    text-align: left;
  }

  section { margin-bottom: 40px; }
  .section-head {
    display: flex;
    align-items: baseline;
    gap: 10px;
    margin-bottom: 14px;
    border-bottom: 1px solid var(--gold-border);
    padding-bottom: 8px;
  }
  .section-head h2 {
    font-family: 'Bebas Neue', sans-serif;
    font-size: 22px;
    letter-spacing: 0.02em;
    color: var(--gold);
  }
  .section-head span {
    font-size: 12px;
    color: var(--muted);
  }

  .grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
    gap: 14px;
  }

  .card {
    display: block;
    background: rgba(255,255,255,0.04);
    border: 1px solid rgba(255,255,255,0.1);
    border-radius: 12px;
    padding: 20px;
    text-decoration: none;
    color: var(--white);
    transition: border-color 0.15s, background 0.15s, transform 0.15s;
  }
  .card:hover {
    border-color: var(--gold-border);
    background: rgba(242,180,0,0.06);
    transform: translateY(-2px);
  }
  .card-title {
    font-weight: 700;
    font-size: 17px;
    margin-bottom: 6px;
  }
  .card-desc {
    font-size: 13px;
    color: var(--muted);
    line-height: 1.5;
  }
  .card-emoji { font-size: 26px; margin-bottom: 8px; display: block; }

  footer {
    text-align: center;
    margin-top: 48px;
    padding-top: 20px;
    border-top: 1px solid rgba(255,255,255,0.1);
    font-size: 12px;
    color: var(--muted);
  }
  footer a { color: var(--gold); }
</style>
</head>
<body>
<div class="wrap">

  <header>
    <div class="eyebrow">Corinda State High School · Open to Everyone</div>
    <h1>Open Resources</h1>
    <p class="lede">Practice games and character strengths resources — no sign-in, open to students, staff and families.</p>
    <div class="note">
      Playing for the leaderboard, or after staff materials? Those live on the staff intranet via QLearn, not here.
    </div>
  </header>

  <section>
    <div class="section-head"><h2>Practice Games</h2><span>unlimited replay, not the leaderboard</span></div>
    <div class="grid">
      <a class="card" href="games/wordle.aspx">
        <span class="card-emoji">🟩</span>
        <div class="card-title">Wordle</div>
        <div class="card-desc">Guess a fresh word — six tries, play again as many times as you like.</div>
      </a>
      <a class="card" href="games/connections.aspx">
        <span class="card-emoji">🔗</span>
        <div class="card-title">Connections</div>
        <div class="card-desc">Find four groups of four — a new puzzle every round.</div>
      </a>
      <a class="card" href="games/countdown.aspx">
        <span class="card-emoji">🔢</span>
        <div class="card-title">Countdown</div>
        <div class="card-desc">Use the numbers to reach a fresh target — any combination.</div>
      </a>
      <a class="card" href="games/wheel-of-fortune.aspx">
        <span class="card-emoji">🎡</span>
        <div class="card-title">Wheel of Fortune</div>
        <div class="card-desc">Spin, guess letters and solve a fresh phrase — play again anytime.</div>
      </a>
    </div>
  </section>

  <section>
    <div class="section-head"><h2>Character Strengths</h2><span>directory &amp; survey</span></div>
    <div class="grid">
      <a class="card" href="character-strengths/index.aspx">
        <span class="card-emoji">🦉</span>
        <div class="card-title">Strengths Activity Directory</div>
        <div class="card-desc">Every VIA virtue and strength, with ready-to-run activities for each.</div>
      </a>
      <a class="card" href="character-strengths/character-strengths-survey.aspx">
        <span class="card-emoji">📋</span>
        <div class="card-title">Character Strengths Survey</div>
        <div class="card-desc">Submit your name, house and top 5 strengths.</div>
      </a>
    </div>
  </section>

  <footer>
    <span>Corinda SHS Positive Education</span>
  </footer>

</div>
</body>
</html>
