<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Positive Education & PERMAH — Teacher Course</title>
<link href="../../assets/fonts/fonts.css" rel="stylesheet">
<style>
  :root {
    --bg: #00180f;
    --bg2: #001e13;
    --bg3: #002918;
    --gold: #f2b400;
    --gold-light: #ffd55a;
    --gold-dim: rgba(242,180,0,0.15);
    --white: #f5f0e8;
    --white-dim: rgba(245,240,232,0.6);
    --white-faint: rgba(245,240,232,0.08);
    --green-mid: #005c2e;
    --green-bright: #00a651;
    --radius: 12px;
    --shadow: 0 8px 40px rgba(0,0,0,0.5);

    /* PERMAH colours */
    --p: #4a90d9;
    --e: #e85d4a;
    --r: #9b59b6;
    --m: #27ae60;
    --a: #f39c12;
    --h: #16a085;
  }

  *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

  html { scroll-behavior: smooth; }

  body {
    background: var(--bg);
    color: var(--white);
    font-family: 'DM Sans', sans-serif;
    font-size: 16px;
    line-height: 1.7;
    min-height: 100vh;
  }

  /* ─── NOISE TEXTURE OVERLAY ─── */
  body::before {
    content: '';
    position: fixed;
    inset: 0;
    background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 256 256' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='n'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23n)' opacity='0.04'/%3E%3C/svg%3E");
    pointer-events: none;
    z-index: 0;
    opacity: 0.4;
  }

  /* ─── PROGRESS BAR ─── */
  #progress-bar {
    position: fixed;
    top: 0; left: 0;
    height: 3px;
    background: linear-gradient(90deg, var(--gold), var(--green-bright));
    width: 0%;
    z-index: 1000;
    transition: width 0.3s ease;
  }

  /* ─── SIDEBAR NAV ─── */
  #sidebar {
    position: fixed;
    left: 0; top: 0; bottom: 0;
    width: 240px;
    background: rgba(0,20,12,0.95);
    border-right: 1px solid rgba(242,180,0,0.2);
    padding: 0;
    z-index: 100;
    display: flex;
    flex-direction: column;
    backdrop-filter: blur(10px);
    transform: translateX(0);
    transition: transform 0.3s ease;
  }

  #sidebar-logo {
    padding: 28px 24px 20px;
    border-bottom: 1px solid rgba(242,180,0,0.15);
  }

  #sidebar-logo .course-label {
    font-family: 'DM Mono', monospace;
    font-size: 9px;
    letter-spacing: 3px;
    text-transform: uppercase;
    color: var(--gold);
    opacity: 0.8;
    margin-bottom: 6px;
  }

  #sidebar-logo .course-title {
    font-family: 'Playfair Display', serif;
    font-size: 16px;
    font-weight: 700;
    color: var(--white);
    line-height: 1.3;
  }

  #nav-list {
    list-style: none;
    padding: 16px 0;
    flex: 1;
    overflow-y: auto;
  }

  #nav-list li a {
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 10px 24px;
    color: var(--white-dim);
    text-decoration: none;
    font-size: 13px;
    font-weight: 500;
    transition: all 0.2s;
    border-left: 3px solid transparent;
    position: relative;
  }

  #nav-list li a:hover, #nav-list li a.active {
    color: var(--gold);
    background: var(--gold-dim);
    border-left-color: var(--gold);
  }

  #nav-list li a .dot {
    width: 8px; height: 8px;
    border-radius: 50%;
    background: currentColor;
    opacity: 0.5;
    flex-shrink: 0;
  }

  #nav-list li a.completed .dot {
    background: var(--green-bright);
    opacity: 1;
  }

  #nav-list .section-label {
    font-family: 'DM Mono', monospace;
    font-size: 9px;
    letter-spacing: 2px;
    text-transform: uppercase;
    color: var(--gold);
    opacity: 0.5;
    padding: 16px 24px 6px;
  }

  #sidebar-footer {
    padding: 16px 24px;
    border-top: 1px solid rgba(242,180,0,0.1);
    font-size: 12px;
    color: var(--white-dim);
    opacity: 0.6;
  }

  /* ─── MAIN CONTENT ─── */
  #main {
    margin-left: 240px;
    min-height: 100vh;
    position: relative;
    z-index: 1;
  }

  /* ─── HERO ─── */
  #hero {
    background: linear-gradient(135deg, #001a0d 0%, #003320 40%, #001a0d 100%);
    padding: 80px 64px;
    border-bottom: 1px solid rgba(242,180,0,0.2);
    position: relative;
    overflow: hidden;
  }

  #hero::after {
    content: 'PERMAH';
    position: absolute;
    right: -20px; top: -20px;
    font-family: 'Playfair Display', serif;
    font-size: 180px;
    font-weight: 900;
    color: rgba(242,180,0,0.04);
    line-height: 1;
    pointer-events: none;
    user-select: none;
  }

  .hero-label {
    font-family: 'DM Mono', monospace;
    font-size: 11px;
    letter-spacing: 4px;
    text-transform: uppercase;
    color: var(--gold);
    margin-bottom: 16px;
  }

  #hero h1 {
    font-family: 'Playfair Display', serif;
    font-size: clamp(32px, 4vw, 52px);
    font-weight: 900;
    line-height: 1.1;
    color: var(--white);
    margin-bottom: 20px;
    max-width: 600px;
  }

  #hero h1 span {
    color: var(--gold);
  }

  #hero p {
    color: var(--white-dim);
    max-width: 540px;
    font-size: 16px;
    margin-bottom: 32px;
  }

  .hero-meta {
    display: flex;
    gap: 32px;
    flex-wrap: wrap;
  }

  .hero-meta-item {
    display: flex;
    align-items: center;
    gap: 8px;
    font-size: 13px;
    color: var(--white-dim);
  }

  .hero-meta-item .icon {
    font-size: 16px;
  }

  /* ─── SECTION STYLES ─── */
  .course-section {
    padding: 64px;
    border-bottom: 1px solid var(--white-faint);
  }

  .course-section:nth-child(even) {
    background: rgba(0,20,12,0.4);
  }

  .section-header {
    display: flex;
    align-items: flex-start;
    gap: 20px;
    margin-bottom: 40px;
  }

  .section-number {
    font-family: 'DM Mono', monospace;
    font-size: 11px;
    letter-spacing: 2px;
    color: var(--gold);
    background: var(--gold-dim);
    border: 1px solid rgba(242,180,0,0.3);
    padding: 4px 10px;
    border-radius: 4px;
    white-space: nowrap;
    margin-top: 8px;
  }

  .section-header h2 {
    font-family: 'Playfair Display', serif;
    font-size: clamp(24px, 3vw, 36px);
    font-weight: 700;
    color: var(--white);
    line-height: 1.2;
  }

  .section-header h2 span {
    color: var(--gold);
  }

  .lead-text {
    font-size: 17px;
    color: var(--white-dim);
    max-width: 680px;
    margin-bottom: 40px;
    line-height: 1.8;
  }

  /* ─── PERMAH PILLARS GRID ─── */
  .permah-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    gap: 20px;
    margin: 32px 0;
  }

  .permah-card {
    background: var(--white-faint);
    border: 1px solid rgba(255,255,255,0.1);
    border-radius: var(--radius);
    padding: 28px;
    position: relative;
    overflow: hidden;
    transition: transform 0.2s, box-shadow 0.2s;
    cursor: pointer;
  }

  .permah-card:hover {
    transform: translateY(-3px);
    box-shadow: var(--shadow);
  }

  .permah-card::before {
    content: '';
    position: absolute;
    top: 0; left: 0; right: 0;
    height: 3px;
    background: var(--card-color);
  }

  .permah-card .letter {
    font-family: 'Playfair Display', serif;
    font-size: 48px;
    font-weight: 900;
    color: var(--card-color);
    line-height: 1;
    margin-bottom: 8px;
    opacity: 0.9;
  }

  .permah-card h3 {
    font-size: 16px;
    font-weight: 600;
    margin-bottom: 8px;
    color: var(--white);
  }

  .permah-card p {
    font-size: 14px;
    color: var(--white-dim);
    line-height: 1.6;
    margin-bottom: 12px;
  }

  .permah-card .examples {
    display: flex;
    flex-wrap: wrap;
    gap: 6px;
  }

  .permah-card .tag {
    font-size: 11px;
    padding: 3px 8px;
    border-radius: 20px;
    background: rgba(255,255,255,0.07);
    color: var(--white-dim);
    border: 1px solid rgba(255,255,255,0.1);
  }

  /* ─── VIDEO EMBED ─── */
  .video-block {
    background: #000;
    border-radius: var(--radius);
    overflow: hidden;
    position: relative;
    margin: 24px 0;
    border: 1px solid rgba(242,180,0,0.2);
  }

  .video-block iframe {
    display: block;
    width: 100%;
    aspect-ratio: 16/9;
    border: none;
  }

  .video-caption {
    padding: 12px 16px;
    background: rgba(0,0,0,0.4);
    font-size: 13px;
    color: var(--white-dim);
  }

  /* ─── RESOURCE LINKS ─── */
  .resource-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
    gap: 16px;
    margin: 24px 0;
  }

  .resource-card {
    display: flex;
    align-items: flex-start;
    gap: 14px;
    background: var(--white-faint);
    border: 1px solid rgba(255,255,255,0.08);
    border-radius: var(--radius);
    padding: 18px;
    text-decoration: none;
    transition: all 0.2s;
  }

  .resource-card:hover {
    background: var(--gold-dim);
    border-color: rgba(242,180,0,0.3);
    transform: translateY(-2px);
  }

  .resource-card .res-icon {
    font-size: 24px;
    flex-shrink: 0;
  }

  .resource-card .res-content h4 {
    font-size: 14px;
    font-weight: 600;
    color: var(--white);
    margin-bottom: 4px;
  }

  .resource-card .res-content p {
    font-size: 12px;
    color: var(--white-dim);
    line-height: 1.5;
  }

  .resource-card .res-type {
    font-family: 'DM Mono', monospace;
    font-size: 10px;
    letter-spacing: 1px;
    color: var(--gold);
    text-transform: uppercase;
    margin-top: 6px;
  }

  /* ─── QUIZ / ACTIVITIES ─── */
  .activity-block {
    background: linear-gradient(135deg, rgba(0,40,20,0.8), rgba(0,25,15,0.8));
    border: 1px solid rgba(242,180,0,0.25);
    border-radius: var(--radius);
    padding: 36px;
    margin: 32px 0;
    position: relative;
  }

  .activity-block::before {
    content: 'ACTIVITY';
    position: absolute;
    top: -1px; right: 20px;
    background: var(--gold);
    color: var(--bg);
    font-family: 'DM Mono', monospace;
    font-size: 10px;
    letter-spacing: 2px;
    padding: 3px 10px;
    border-radius: 0 0 6px 6px;
    font-weight: 500;
  }

  .activity-block h3 {
    font-family: 'Playfair Display', serif;
    font-size: 20px;
    color: var(--gold);
    margin-bottom: 12px;
  }

  .activity-block p {
    color: var(--white-dim);
    margin-bottom: 20px;
    font-size: 15px;
  }

  /* Quiz styles */
  .quiz-question {
    margin-bottom: 28px;
  }

  .quiz-question .q-text {
    font-weight: 600;
    color: var(--white);
    margin-bottom: 14px;
    font-size: 15px;
    line-height: 1.5;
  }

  .quiz-options {
    display: flex;
    flex-direction: column;
    gap: 8px;
  }

  .quiz-option {
    display: flex;
    align-items: center;
    gap: 12px;
    padding: 12px 16px;
    background: rgba(255,255,255,0.04);
    border: 1px solid rgba(255,255,255,0.1);
    border-radius: 8px;
    cursor: pointer;
    transition: all 0.2s;
    font-size: 14px;
    color: var(--white-dim);
    text-align: left;
    width: 100%;
  }

  .quiz-option:hover { background: rgba(255,255,255,0.08); color: var(--white); }
  .quiz-option.correct { background: rgba(0,166,81,0.2); border-color: var(--green-bright); color: var(--white); }
  .quiz-option.incorrect { background: rgba(232,93,74,0.2); border-color: #e85d4a; color: var(--white); }
  .quiz-option.disabled { pointer-events: none; opacity: 0.5; }
  .quiz-option .opt-letter {
    font-family: 'DM Mono', monospace;
    font-size: 11px;
    font-weight: 600;
    color: var(--gold);
    width: 20px;
    flex-shrink: 0;
  }

  .quiz-feedback {
    margin-top: 12px;
    padding: 12px 16px;
    border-radius: 8px;
    font-size: 14px;
    display: none;
  }

  .quiz-feedback.show { display: block; }
  .quiz-feedback.correct-fb { background: rgba(0,166,81,0.15); color: #6ee7a0; border: 1px solid rgba(0,166,81,0.3); }
  .quiz-feedback.incorrect-fb { background: rgba(232,93,74,0.15); color: #fca5a5; border: 1px solid rgba(232,93,74,0.3); }

  /* Reflection prompts */
  .reflection-prompt {
    background: rgba(255,255,255,0.03);
    border-left: 3px solid var(--gold);
    padding: 20px 24px;
    border-radius: 0 8px 8px 0;
    margin: 16px 0;
  }

  .reflection-prompt p { color: var(--white-dim); font-size: 15px; margin-bottom: 12px; font-style: italic; }

  .reflection-textarea {
    width: 100%;
    min-height: 100px;
    background: rgba(255,255,255,0.05);
    border: 1px solid rgba(255,255,255,0.15);
    border-radius: 8px;
    padding: 12px 16px;
    color: var(--white);
    font-family: 'DM Sans', sans-serif;
    font-size: 14px;
    resize: vertical;
    transition: border-color 0.2s;
    outline: none;
  }

  .reflection-textarea:focus { border-color: var(--gold); }
  .reflection-textarea::placeholder { color: rgba(245,240,232,0.3); }

  /* Slider activity */
  .slider-group {
    margin: 20px 0;
  }

  .slider-item {
    margin-bottom: 20px;
  }

  .slider-label {
    display: flex;
    justify-content: space-between;
    margin-bottom: 8px;
  }

  .slider-label span:first-child { font-size: 14px; color: var(--white); }
  .slider-label .slider-value {
    font-family: 'DM Mono', monospace;
    font-size: 14px;
    color: var(--gold);
    font-weight: 600;
  }

  input[type=range] {
    -webkit-appearance: none;
    width: 100%;
    height: 4px;
    background: rgba(255,255,255,0.1);
    border-radius: 2px;
    outline: none;
  }

  input[type=range]::-webkit-slider-thumb {
    -webkit-appearance: none;
    width: 18px; height: 18px;
    border-radius: 50%;
    background: var(--gold);
    cursor: pointer;
    box-shadow: 0 0 8px rgba(242,180,0,0.5);
  }

  .btn {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    padding: 11px 24px;
    border-radius: 8px;
    font-family: 'DM Sans', sans-serif;
    font-size: 14px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.2s;
    border: none;
    text-decoration: none;
  }

  .btn-primary {
    background: var(--gold);
    color: var(--bg);
  }

  .btn-primary:hover { background: var(--gold-light); transform: translateY(-1px); }

  .btn-secondary {
    background: transparent;
    color: var(--gold);
    border: 1px solid rgba(242,180,0,0.4);
  }

  .btn-secondary:hover { background: var(--gold-dim); }

  /* Sort activity */
  .sort-container {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 20px;
    margin: 16px 0;
  }

  .sort-bank, .sort-target {
    min-height: 120px;
    background: rgba(255,255,255,0.04);
    border: 2px dashed rgba(255,255,255,0.15);
    border-radius: 8px;
    padding: 12px;
  }

  .sort-target { border-color: rgba(242,180,0,0.25); }

  .sort-bank h4, .sort-target h4 {
    font-size: 12px;
    font-family: 'DM Mono', monospace;
    letter-spacing: 1px;
    text-transform: uppercase;
    color: var(--white-dim);
    margin-bottom: 10px;
  }

  .sort-chip {
    display: inline-block;
    padding: 6px 12px;
    margin: 4px;
    background: rgba(255,255,255,0.08);
    border: 1px solid rgba(255,255,255,0.15);
    border-radius: 20px;
    font-size: 13px;
    color: var(--white);
    cursor: grab;
    transition: all 0.15s;
    user-select: none;
  }

  .sort-chip:hover { background: var(--gold-dim); border-color: rgba(242,180,0,0.4); }
  .sort-chip.dragging { opacity: 0.4; cursor: grabbing; }
  .sort-chip.placed { cursor: pointer; }

  /* Info callout */
  .callout {
    display: flex;
    gap: 16px;
    padding: 20px 24px;
    border-radius: var(--radius);
    margin: 24px 0;
  }

  .callout-info { background: rgba(74,144,217,0.1); border: 1px solid rgba(74,144,217,0.25); }
  .callout-tip { background: rgba(242,180,0,0.08); border: 1px solid rgba(242,180,0,0.2); }
  .callout-research { background: rgba(155,89,182,0.1); border: 1px solid rgba(155,89,182,0.25); }

  .callout-icon { font-size: 20px; flex-shrink: 0; margin-top: 2px; }
  .callout-body h4 { font-size: 14px; font-weight: 600; margin-bottom: 6px; color: var(--white); }
  .callout-body p { font-size: 14px; color: var(--white-dim); line-height: 1.6; }

  /* Accordion */
  .accordion {
    margin: 16px 0;
    border: 1px solid rgba(255,255,255,0.1);
    border-radius: var(--radius);
    overflow: hidden;
  }

  .accordion-item {
    border-bottom: 1px solid rgba(255,255,255,0.07);
  }

  .accordion-item:last-child { border-bottom: none; }

  .accordion-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 16px 20px;
    cursor: pointer;
    background: rgba(255,255,255,0.03);
    transition: background 0.2s;
    font-size: 14px;
    font-weight: 600;
    color: var(--white);
    user-select: none;
  }

  .accordion-header:hover { background: rgba(255,255,255,0.06); }
  .accordion-header .chevron { font-size: 12px; color: var(--gold); transition: transform 0.3s; }
  .accordion-header.open .chevron { transform: rotate(180deg); }

  .accordion-body {
    padding: 0 20px;
    max-height: 0;
    overflow: hidden;
    transition: max-height 0.4s ease, padding 0.3s;
    font-size: 14px;
    color: var(--white-dim);
    line-height: 1.7;
  }

  .accordion-body.open {
    padding: 16px 20px;
    max-height: 600px;
  }

  /* Progress tracker */
  .module-progress {
    display: flex;
    align-items: center;
    gap: 12px;
    padding: 16px 24px;
    background: var(--gold-dim);
    border: 1px solid rgba(242,180,0,0.2);
    border-radius: var(--radius);
    margin: 24px 0;
  }

  .module-progress .progress-icon { font-size: 20px; }
  .module-progress .progress-text { font-size: 14px; color: var(--white-dim); }
  .module-progress .progress-text strong { color: var(--gold); }

  #progress-track {
    display: flex;
    gap: 8px;
    padding: 20px 64px;
    background: rgba(0,0,0,0.2);
    border-bottom: 1px solid var(--white-faint);
    overflow-x: auto;
  }

  .track-step {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 6px;
    min-width: 80px;
    cursor: pointer;
  }

  .track-step .step-dot {
    width: 32px; height: 32px;
    border-radius: 50%;
    background: rgba(255,255,255,0.07);
    border: 2px solid rgba(255,255,255,0.15);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 13px;
    color: var(--white-dim);
    transition: all 0.3s;
    font-family: 'DM Mono', monospace;
    font-weight: 600;
  }

  .track-step.active .step-dot {
    background: var(--gold);
    border-color: var(--gold);
    color: var(--bg);
  }

  .track-step.done .step-dot {
    background: var(--green-mid);
    border-color: var(--green-bright);
    color: var(--green-bright);
  }

  .track-step .step-label {
    font-size: 10px;
    color: var(--white-dim);
    text-align: center;
    line-height: 1.3;
    max-width: 72px;
  }

  /* Highlight box */
  .highlight-box {
    background: linear-gradient(135deg, rgba(242,180,0,0.08), rgba(242,180,0,0.03));
    border: 1px solid rgba(242,180,0,0.2);
    border-radius: var(--radius);
    padding: 28px 32px;
    margin: 24px 0;
  }

  .highlight-box blockquote {
    font-family: 'Playfair Display', serif;
    font-size: 20px;
    font-style: italic;
    color: var(--white);
    line-height: 1.5;
    margin-bottom: 12px;
  }

  .highlight-box cite {
    font-size: 13px;
    color: var(--gold);
    font-style: normal;
  }

  /* Checklist */
  .checklist {
    list-style: none;
    margin: 16px 0;
  }

  .checklist li {
    display: flex;
    align-items: flex-start;
    gap: 12px;
    padding: 10px 0;
    border-bottom: 1px solid rgba(255,255,255,0.06);
    font-size: 14px;
    color: var(--white-dim);
  }

  .checklist li:last-child { border-bottom: none; }

  .check-box {
    width: 18px; height: 18px;
    border: 2px solid rgba(242,180,0,0.4);
    border-radius: 4px;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    flex-shrink: 0;
    margin-top: 2px;
    transition: all 0.2s;
  }

  .check-box.checked {
    background: var(--gold);
    border-color: var(--gold);
    color: var(--bg);
    font-size: 11px;
  }

  /* Section divider */
  .divider {
    display: flex;
    align-items: center;
    gap: 16px;
    margin: 40px 0;
    color: var(--white-dim);
    font-size: 12px;
    font-family: 'DM Mono', monospace;
    letter-spacing: 2px;
    text-transform: uppercase;
  }

  .divider::before, .divider::after {
    content: '';
    flex: 1;
    height: 1px;
    background: rgba(255,255,255,0.1);
  }

  /* Two-column layout */
  .two-col {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 32px;
    align-items: start;
  }

  @media (max-width: 900px) {
    .two-col { grid-template-columns: 1fr; }
  }

  /* Stat cards */
  .stats-row {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(160px, 1fr));
    gap: 16px;
    margin: 24px 0;
  }

  .stat-card {
    background: var(--white-faint);
    border: 1px solid rgba(255,255,255,0.08);
    border-radius: var(--radius);
    padding: 24px 20px;
    text-align: center;
  }

  .stat-card .stat-num {
    font-family: 'Playfair Display', serif;
    font-size: 36px;
    font-weight: 700;
    color: var(--gold);
    line-height: 1;
    margin-bottom: 6px;
  }

  .stat-card .stat-label {
    font-size: 12px;
    color: var(--white-dim);
    line-height: 1.4;
  }

  /* Mobile */
  @media (max-width: 768px) {
    #sidebar { transform: translateX(-240px); }
    #sidebar.open { transform: translateX(0); }
    #main { margin-left: 0; }
    .course-section, #hero { padding: 40px 24px; }
    #progress-track { padding: 16px 24px; }
    #hero::after { display: none; }
  }

  /* ─── APST CARD STYLES ─── */
  .apst-card {
    border-radius: var(--radius);
    padding: 22px 26px;
    position: relative;
    transition: transform 0.2s;
  }

  .apst-card.apst-applicable {
    background: linear-gradient(135deg, rgba(0,40,20,0.7), rgba(0,25,12,0.5));
    border: 1px solid rgba(242,180,0,0.25);
    border-left: 4px solid var(--gold);
  }

  .apst-card.apst-not-applicable {
    background: rgba(255,255,255,0.02);
    border: 1px solid rgba(255,255,255,0.07);
    border-left: 4px solid rgba(255,255,255,0.1);
    opacity: 0.55;
  }

  .apst-badge {
    display: inline-block;
    font-family: 'DM Mono', monospace;
    font-size: 10px;
    letter-spacing: 1.5px;
    text-transform: uppercase;
    padding: 3px 10px;
    border-radius: 20px;
    margin-bottom: 10px;
    font-weight: 600;
  }

  .apst-badge.applicable {
    background: rgba(0,166,81,0.2);
    color: var(--green-bright);
    border: 1px solid rgba(0,166,81,0.4);
  }

  .apst-badge.not-applicable {
    background: rgba(255,255,255,0.05);
    color: var(--white-dim);
    border: 1px solid rgba(255,255,255,0.1);
  }

  .apst-num {
    font-family: 'DM Mono', monospace;
    font-size: 11px;
    color: var(--gold);
    letter-spacing: 1px;
    margin-bottom: 3px;
  }

  .apst-card.apst-not-applicable .apst-num {
    color: var(--white-dim);
  }

  .apst-title {
    font-family: 'Playfair Display', serif;
    font-size: 17px;
    font-weight: 700;
    color: var(--white);
    margin-bottom: 10px;
  }

  .apst-body p {
    font-size: 14px;
    color: var(--white-dim);
    line-height: 1.7;
    margin-bottom: 12px;
  }

  .apst-focus-areas {
    display: flex;
    flex-wrap: wrap;
    gap: 6px;
  }

  .apst-tag {
    font-size: 11px;
    padding: 4px 10px;
    border-radius: 20px;
    background: rgba(242,180,0,0.1);
    color: rgba(242,180,0,0.8);
    border: 1px solid rgba(242,180,0,0.2);
    font-family: 'DM Mono', monospace;
    letter-spacing: 0.3px;
  }

  /* ─── ASSESSMENT STYLES ─── */
  .assessment-q {
    background: rgba(255,255,255,0.03);
    border: 1px solid rgba(255,255,255,0.09);
    border-radius: var(--radius);
    padding: 24px 28px;
    margin-bottom: 20px;
    transition: border-color 0.3s;
  }

  .assessment-q.q-correct { border-color: rgba(0,166,81,0.5); background: rgba(0,166,81,0.05); }
  .assessment-q.q-incorrect { border-color: rgba(232,93,74,0.5); background: rgba(232,93,74,0.05); }

  .aq-header {
    display: flex;
    gap: 14px;
    align-items: flex-start;
    margin-bottom: 16px;
  }

  .aq-num {
    font-family: 'DM Mono', monospace;
    font-size: 11px;
    font-weight: 600;
    color: var(--gold);
    background: var(--gold-dim);
    border: 1px solid rgba(242,180,0,0.3);
    padding: 3px 8px;
    border-radius: 4px;
    white-space: nowrap;
    margin-top: 2px;
    flex-shrink: 0;
  }

  .aq-text {
    font-size: 15px;
    font-weight: 600;
    color: var(--white);
    line-height: 1.5;
  }

  .aq-options {
    display: flex;
    flex-direction: column;
    gap: 8px;
    padding-left: 30px;
  }

  .aq-opt {
    display: flex;
    align-items: center;
    gap: 12px;
    padding: 11px 16px;
    background: rgba(255,255,255,0.04);
    border: 1px solid rgba(255,255,255,0.1);
    border-radius: 8px;
    cursor: pointer;
    transition: all 0.2s;
    font-size: 14px;
    color: var(--white-dim);
  }

  .aq-opt:hover { background: rgba(255,255,255,0.08); color: var(--white); }
  .aq-opt input[type=radio] { accent-color: var(--gold); width: 16px; height: 16px; flex-shrink: 0; cursor: pointer; }

  .aq-opt.correct-ans { background: rgba(0,166,81,0.2); border-color: var(--green-bright); color: var(--white); }
  .aq-opt.wrong-ans { background: rgba(232,93,74,0.2); border-color: #e85d4a; color: var(--white); }
  .aq-opt.show-correct { background: rgba(0,166,81,0.12); border-color: rgba(0,166,81,0.5); color: #6ee7a0; }

  .assessment-q.locked .aq-opt { pointer-events: none; }

  .aq-feedback {
    margin-top: 10px;
    margin-left: 30px;
    font-size: 13px;
    color: var(--white-dim);
    display: none;
  }

  .aq-feedback.show { display: block; }

  /* Score result */
  .score-display {
    text-align: center;
    padding: 48px 32px;
    border-radius: var(--radius);
    margin-bottom: 24px;
  }

  .score-display.pass { background: linear-gradient(135deg, rgba(0,166,81,0.2), rgba(0,92,46,0.1)); border: 1px solid rgba(0,166,81,0.4); }
  .score-display.fail { background: linear-gradient(135deg, rgba(232,93,74,0.15), rgba(180,50,30,0.1)); border: 1px solid rgba(232,93,74,0.3); }

  .score-ring {
    width: 120px; height: 120px;
    border-radius: 50%;
    margin: 0 auto 24px;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-direction: column;
    font-family: 'Playfair Display', serif;
  }

  .score-ring.pass { background: radial-gradient(circle, rgba(0,166,81,0.3), rgba(0,40,20,0.5)); border: 3px solid var(--green-bright); box-shadow: 0 0 30px rgba(0,166,81,0.3); }
  .score-ring.fail { background: radial-gradient(circle, rgba(232,93,74,0.2), rgba(40,10,5,0.5)); border: 3px solid #e85d4a; }

  .score-ring .score-num { font-size: 36px; font-weight: 900; line-height: 1; }
  .score-ring.pass .score-num { color: #6ee7a0; }
  .score-ring.fail .score-num { color: #fca5a5; }
  .score-ring .score-denom { font-size: 14px; color: var(--white-dim); }

  /* Animations */
  @keyframes fadeUp {
    from { opacity: 0; transform: translateY(20px); }
    to { opacity: 1; transform: translateY(0); }
  }

  .fade-up { animation: fadeUp 0.6s ease forwards; }

  .course-section { opacity: 0; transform: translateY(16px); transition: opacity 0.5s ease, transform 0.5s ease; }
  .course-section.visible { opacity: 1; transform: none; }
</style>
</head>
<body>

<div id="progress-bar"></div>

<!-- SIDEBAR -->
<nav id="sidebar">
  <div id="sidebar-logo">
    <div class="course-label">Self-Paced Course</div>
    <div class="course-title">Positive Education & PERMAH</div>
  </div>
  <ul id="nav-list">
    <li class="section-label">Introduction</li>
    <li><a href="#hero" class="active"><span class="dot"></span>Welcome</a></li>
    <li><a href="#sec-what"><span class="dot"></span>What is Positive Ed?</a></li>
    <li><a href="#sec-why"><span class="dot"></span>Why It Matters</a></li>

    <li class="section-label">PERMAH Framework</li>
    <li><a href="#sec-permah"><span class="dot"></span>The Six Pillars</a></li>
    <li><a href="#sec-p"><span class="dot"></span>Pillars in Practice</a></li>

    <li class="section-label">Application</li>
    <li><a href="#sec-classroom"><span class="dot"></span>In Your Classroom</a></li>
    <li><a href="#sec-self"><span class="dot"></span>Teacher Wellbeing</a></li>
    <li><a href="#sec-resources"><span class="dot"></span>Resources & Tools</a></li>
    <li><a href="#sec-apst"><span class="dot"></span>APST Alignment</a></li>

    <li class="section-label">Assessment</li>
    <li><a href="#sec-assessment"><span class="dot"></span>Final Assessment</a></li>
  </ul>
  <div id="sidebar-footer">Corinda SHS · Positive Education</div>
</nav>

<!-- MAIN -->
<div id="main">

  <!-- HERO -->
  <section id="hero">
    <div class="hero-label">Module 1 · Foundations</div>
    <h1>Flourishing in the<br><span>Classroom & Beyond</span></h1>
    <p>A self-paced introduction to Positive Education and the PERMAH framework — designed for teachers who want to build wellbeing into everyday school life.</p>
    <div class="hero-meta">
      <div class="hero-meta-item"><span class="icon">🕐</span> Approx. 60–90 min</div>
      <div class="hero-meta-item"><span class="icon">📚</span> Self-paced</div>
      <div class="hero-meta-item"><span class="icon">🏫</span> For Educators</div>
      <div class="hero-meta-item"><span class="icon">✏️</span> Activities included</div>
    </div>
  </section>

  <!-- PROGRESS TRACK -->
  <div id="progress-track">
    <div class="track-step active" onclick="scrollTo('#sec-what')">
      <div class="step-dot">1</div>
      <div class="step-label">What is Positive Ed?</div>
    </div>
    <div class="track-step" onclick="scrollTo('#sec-why')">
      <div class="step-dot">2</div>
      <div class="step-label">Why It Matters</div>
    </div>
    <div class="track-step" onclick="scrollTo('#sec-permah')">
      <div class="step-dot">3</div>
      <div class="step-label">PERMAH Overview</div>
    </div>
    <div class="track-step" onclick="scrollTo('#sec-p')">
      <div class="step-dot">4</div>
      <div class="step-label">Pillars in Practice</div>
    </div>
    <div class="track-step" onclick="scrollTo('#sec-classroom')">
      <div class="step-dot">5</div>
      <div class="step-label">In the Classroom</div>
    </div>
    <div class="track-step" onclick="scrollTo('#sec-resources')">
      <div class="step-dot">6</div>
      <div class="step-label">Resources</div>
    </div>
    <div class="track-step" onclick="scrollTo('#sec-apst')">
      <div class="step-dot">7</div>
      <div class="step-label">APST</div>
    </div>
    <div class="track-step" onclick="scrollTo('#sec-assessment')">
      <div class="step-dot">8</div>
      <div class="step-label">Assessment</div>
    </div>
  </div>

  <!-- ─── SECTION 1: WHAT IS POSITIVE EDUCATION ─── -->
  <section class="course-section" id="sec-what">
    <div class="section-header">
      <div class="section-number">01</div>
      <h2>What is <span>Positive Education?</span></h2>
    </div>

    <p class="lead-text">Positive Education applies the science of positive psychology to schools — combining academic achievement with student wellbeing so that young people don't just succeed, but truly flourish.</p>

    <div class="highlight-box">
      <blockquote>"Positive Education is education for both traditional skills and for happiness."</blockquote>
      <cite>— Martin Seligman, Father of Positive Psychology</cite>
    </div>

    <div class="two-col">
      <div class="callout callout-info">
        <span class="callout-icon">💡</span>
        <div class="callout-body">
          <h4>Grounded in Science</h4>
          <p>Positive Education is evidence-based — drawing on neuroscience, developmental psychology, and positive psychology research. It adds an intentional focus on character strengths, emotional literacy, and resilience alongside academic learning, without sacrificing rigour.</p>
        </div>
      </div>
      <div class="callout callout-tip">
        <span class="callout-icon">🏫</span>
        <div class="callout-body">
          <h4>An Australian Story</h4>
          <p>Martin Seligman (University of Pennsylvania) pioneered the field. In 2009, Geelong Grammar School became the first school globally to embed whole-school Positive Education. Today, hundreds of Australian schools — including many in Queensland — use the framework.</p>
        </div>
      </div>
    </div>

    <div style="background:linear-gradient(135deg,rgba(232,93,74,0.08),rgba(180,50,30,0.04));border:1px solid rgba(232,93,74,0.3);border-radius:var(--radius);padding:22px 26px;margin:24px 0;display:flex;gap:16px;align-items:flex-start;">
      <span style="font-size:22px;flex-shrink:0;margin-top:2px;">⚠️</span>
      <div>
        <h4 style="font-size:14px;font-weight:700;color:var(--white);margin-bottom:6px;">Not "Toxic Positivity" — an important distinction</h4>
        <p style="font-size:14px;color:var(--white-dim);line-height:1.7;margin:0;">Positive Education is <em>not</em> about forcing happiness, ignoring difficulty, or expecting students to feel cheerful regardless of their circumstances. Research warns that programmes which dismiss negative emotions can create an atmosphere of <strong style="color:var(--white)">toxic positivity</strong> — particularly for students whose life experiences are genuinely challenging. Authentic Pos Ed makes deliberate space for struggle, frustration, and failure as natural and important parts of learning and growth. The goal is <strong style="color:var(--white)">flourishing</strong> — a full life that includes both positive and negative experiences — not the performance of happiness.</p>
      </div>
    </div>

    <div class="activity-block">
      <h3>✏️ Quick Check: What Do You Already Know?</h3>
      <p>Answer these two questions before moving on — they'll prime your thinking for the rest of the course.</p>

      <div class="quiz-question">
        <div class="q-text">1. Which statement best describes Positive Education?</div>
        <div class="quiz-options">
          <button class="quiz-option" onclick="answerQuiz(this, false, 'q1')"><span class="opt-letter">A</span>Making school a happy place where nothing goes wrong</button>
          <button class="quiz-option" onclick="answerQuiz(this, true, 'q1')"><span class="opt-letter">B</span>Intentionally building wellbeing skills alongside academic learning</button>
          <button class="quiz-option" onclick="answerQuiz(this, false, 'q1')"><span class="opt-letter">C</span>A counselling program for students with mental health challenges</button>
          <button class="quiz-option" onclick="answerQuiz(this, false, 'q1')"><span class="opt-letter">D</span>Replacing traditional subjects with mindfulness classes</button>
        </div>
        <div class="quiz-feedback" id="q1-fb"></div>
      </div>

      <div class="quiz-question">
        <div class="q-text">2. Research shows that teachers who experience higher wellbeing tend to:</div>
        <div class="quiz-options">
          <button class="quiz-option" onclick="answerQuiz(this, false, 'q2')"><span class="opt-letter">A</span>Be less likely to challenge students academically</button>
          <button class="quiz-option" onclick="answerQuiz(this, false, 'q2')"><span class="opt-letter">B</span>Focus only on their own needs rather than students'</button>
          <button class="quiz-option" onclick="answerQuiz(this, true, 'q2')"><span class="opt-letter">C</span>Have better student relationships and higher student achievement</button>
          <button class="quiz-option" onclick="answerQuiz(this, false, 'q2')"><span class="opt-letter">D</span>Report greater job satisfaction but no impact on students</button>
        </div>
        <div class="quiz-feedback" id="q2-fb"></div>
      </div>
    </div>
  </section>

  <!-- ─── SECTION 2: WHY IT MATTERS ─── -->
  <section class="course-section" id="sec-why">
    <div class="section-header">
      <div class="section-number">02</div>
      <h2>Why It <span>Matters for Schools</span></h2>
    </div>

    <p class="lead-text">Australian students are facing increasing rates of anxiety, disengagement, and mental health challenges. Positive Education offers schools a proactive, evidence-based response.</p>

    <div class="stats-row">
      <div class="stat-card">
        <div class="stat-num">1 in 7</div>
        <div class="stat-label">Australian children aged 4–17 experience a mental health disorder</div>
      </div>
      <div class="stat-card">
        <div class="stat-num">75%</div>
        <div class="stat-label">of mental health problems emerge before age 25</div>
      </div>
      <div class="stat-card">
        <div class="stat-num">47%</div>
        <div class="stat-label">of teachers consider leaving the profession within 5 years</div>
      </div>
      <div class="stat-card">
        <div class="stat-num">11%</div>
        <div class="stat-label">improvement in student achievement linked to wellbeing programmes (meta-analysis)</div>
      </div>
    </div>

    <div class="callout callout-research">
      <span class="callout-icon">🔬</span>
      <div class="callout-body">
        <h4>The Research Evidence</h4>
        <p>A 2011 meta-analysis of 213 school-based wellbeing programs found students showed improved social skills, reduced problem behaviours, and better academic performance. Wellbeing and achievement are not in competition — they reinforce each other.</p>
      </div>
    </div>
  </section>

  <!-- ─── SECTION 3: PERMAH OVERVIEW ─── -->
  <section class="course-section" id="sec-permah">
    <div class="section-header">
      <div class="section-number">03</div>
      <h2>The <span>PERMAH Framework</span></h2>
    </div>

    <p class="lead-text">PERMAH is a science-based framework for wellbeing, developed from Seligman's original PERMA model with the addition of <strong style="color:var(--white)">Health</strong>. Each pillar represents a domain that contributes to human flourishing.</p>

    <div class="callout callout-tip">
      <span class="callout-icon">🌱</span>
      <div class="callout-body">
        <h4>The PERMAH Survey</h4>
        <p>The PERMAH Wellbeing Survey (developed by the Positive Education Schools Association) is widely used in Australian schools to measure student and staff wellbeing across all six domains. Your school may already use it.</p>
      </div>
    </div>

    <div class="permah-grid">
      <div class="permah-card" style="--card-color: var(--p)">
        <div class="letter">P</div>
        <h3>Positive Emotions</h3>
        <p>Experiencing joy, gratitude, hope, love, curiosity and other positive feelings that broaden our thinking and build resources.</p>
        <div class="examples">
          <span class="tag">Gratitude</span><span class="tag">Joy</span><span class="tag">Hope</span><span class="tag">Curiosity</span>
        </div>
      </div>
      <div class="permah-card" style="--card-color: var(--e)">
        <div class="letter">E</div>
        <h3>Engagement</h3>
        <p>Being fully absorbed in activities — the experience of flow where time disappears and we're at our best.</p>
        <div class="examples">
          <span class="tag">Flow</span><span class="tag">Strengths</span><span class="tag">Interest</span><span class="tag">Absorption</span>
        </div>
      </div>
      <div class="permah-card" style="--card-color: var(--r)">
        <div class="letter">R</div>
        <h3>Relationships</h3>
        <p>Positive connections with others — feeling loved, supported, and valued within a community.</p>
        <div class="examples">
          <span class="tag">Connection</span><span class="tag">Kindness</span><span class="tag">Trust</span><span class="tag">Belonging</span>
        </div>
      </div>
      <div class="permah-card" style="--card-color: var(--m)">
        <div class="letter">M</div>
        <h3>Meaning</h3>
        <p>Belonging to and serving something bigger than yourself — having purpose and direction in life.</p>
        <div class="examples">
          <span class="tag">Purpose</span><span class="tag">Values</span><span class="tag">Service</span><span class="tag">Contribution</span>
        </div>
      </div>
      <div class="permah-card" style="--card-color: var(--a)">
        <div class="letter">A</div>
        <h3>Accomplishment</h3>
        <p>Pursuing and achieving goals — building a sense of mastery, competence and progress over time.</p>
        <div class="examples">
          <span class="tag">Goals</span><span class="tag">Mastery</span><span class="tag">Grit</span><span class="tag">Growth</span>
        </div>
      </div>
      <div class="permah-card" style="--card-color: var(--h)">
        <div class="letter">H</div>
        <h3>Health</h3>
        <p>Physical health as a foundation for wellbeing — sleep, movement, nutrition, and physical literacy.</p>
        <div class="examples">
          <span class="tag">Sleep</span><span class="tag">Movement</span><span class="tag">Nutrition</span><span class="tag">Energy</span>
        </div>
      </div>
    </div>
  </section>

  <!-- ─── DEEP DIVES (COMBINED) ─── -->
  <section class="course-section" id="sec-p">
    <div class="section-header">
      <div class="section-number">04</div>
      <h2>The Pillars in <span>Practice</span></h2>
    </div>
    <p class="lead-text">Each PERMAH pillar has a strong evidence base and clear classroom applications. Here are the key research ideas and practical strategies for each one.</p>

    <div style="display:flex;flex-direction:column;gap:20px;">

      <!-- P -->
      <div style="background:rgba(74,144,217,0.06);border:1px solid rgba(74,144,217,0.2);border-left:4px solid var(--p);border-radius:var(--radius);padding:24px 28px;">
        <div style="display:flex;align-items:center;gap:12px;margin-bottom:12px;">
          <span style="font-family:'Playfair Display',serif;font-size:28px;font-weight:900;color:var(--p);line-height:1;">P</span>
          <div>
            <div style="font-size:16px;font-weight:700;color:var(--white)">Positive Emotions</div>
            <div style="font-size:12px;color:rgba(74,144,217,0.8);font-family:'DM Mono',monospace;">Fredrickson's Broaden-and-Build Theory</div>
          </div>
        </div>
        <p style="font-size:14px;color:var(--white-dim);margin-bottom:14px;line-height:1.7;">Positive emotions do more than feel good — Fredrickson's research shows they <em>broaden</em> our thinking and <em>build</em> lasting psychological, social, and physical resources. Even brief positive experiences compound into resilience over time. This makes deliberately cultivating positive emotions in your classroom a high-leverage strategy, not a nice-to-have.</p>
        <div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(200px,1fr));gap:8px;">
          <div style="background:rgba(74,144,217,0.1);border-radius:8px;padding:10px 14px;font-size:13px;color:var(--white-dim);">📓 <strong style="color:var(--white)">3 Good Things</strong> — students write 3 positive events at the end of each lesson</div>
          <div style="background:rgba(74,144,217,0.1);border-radius:8px;padding:10px 14px;font-size:13px;color:var(--white-dim);">🎉 <strong style="color:var(--white)">Celebrate effort</strong> — acknowledge learning milestones, not just marks</div>
          <div style="background:rgba(74,144,217,0.1);border-radius:8px;padding:10px 14px;font-size:13px;color:var(--white-dim);">💬 <strong style="color:var(--white)">Opening circles</strong> — share one good thing before class begins</div>
        </div>
      </div>

      <!-- E -->
      <div style="background:rgba(232,93,74,0.06);border:1px solid rgba(232,93,74,0.2);border-left:4px solid var(--e);border-radius:var(--radius);padding:24px 28px;" id="sec-e">
        <div style="display:flex;align-items:center;gap:12px;margin-bottom:12px;">
          <span style="font-family:'Playfair Display',serif;font-size:28px;font-weight:900;color:var(--e);line-height:1;">E</span>
          <div>
            <div style="font-size:16px;font-weight:700;color:var(--white)">Engagement</div>
            <div style="font-size:12px;color:rgba(232,93,74,0.8);font-family:'DM Mono',monospace;">Csikszentmihalyi's Flow · VIA Character Strengths</div>
          </div>
        </div>
        <p style="font-size:14px;color:var(--white-dim);margin-bottom:14px;line-height:1.7;">Flow occurs when challenge and skill are balanced — too easy produces boredom, too hard produces anxiety. The sweet spot is where deep absorption happens. VIA research shows that when students use their top character strengths in tasks, they experience more flow, energy, and intrinsic motivation. Identifying strengths is a powerful first step.</p>
        <div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(200px,1fr));gap:8px;margin-bottom:14px;">
          <div style="background:rgba(232,93,74,0.1);border-radius:8px;padding:10px 14px;font-size:13px;color:var(--white-dim);">🌊 <strong style="color:var(--white)">Calibrate challenge</strong> — design tasks at the edge of students' current ability</div>
          <div style="background:rgba(232,93,74,0.1);border-radius:8px;padding:10px 14px;font-size:13px;color:var(--white-dim);">💪 <strong style="color:var(--white)">Strengths-based tasks</strong> — give students choice to use their natural strengths</div>
          <div style="background:rgba(232,93,74,0.1);border-radius:8px;padding:10px 14px;font-size:13px;color:var(--white-dim);">🔍 <strong style="color:var(--white)">Know their strengths</strong> — use the free VIA survey with your class</div>
        </div>
        <a href="https://www.viacharacter.org/survey/account/register" target="_blank" class="btn btn-secondary" style="font-size:12px;padding:7px 16px;">🔗 Free VIA Character Strengths Survey</a>
      </div>

      <!-- R -->
      <div style="background:rgba(155,89,182,0.06);border:1px solid rgba(155,89,182,0.2);border-left:4px solid var(--r);border-radius:var(--radius);padding:24px 28px;" id="sec-r">
        <div style="display:flex;align-items:center;gap:12px;margin-bottom:12px;">
          <span style="font-family:'Playfair Display',serif;font-size:28px;font-weight:900;color:var(--r);line-height:1;">R</span>
          <div>
            <div style="font-size:16px;font-weight:700;color:var(--white)">Relationships</div>
            <div style="font-size:12px;color:rgba(155,89,182,0.8);font-family:'DM Mono',monospace;">Hattie's Visible Learning · Belonging research</div>
          </div>
        </div>
        <p style="font-size:14px;color:var(--white-dim);margin-bottom:14px;line-height:1.7;">Hattie's meta-analysis of 800,000+ studies places teacher-student relationships among the highest-impact influences on achievement. Students who feel known, valued, and connected are more likely to take academic risks, persist through difficulty, and seek help when they need it. Relationship is the precondition for learning.</p>
        <div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(200px,1fr));gap:8px;">
          <div style="background:rgba(155,89,182,0.1);border-radius:8px;padding:10px 14px;font-size:13px;color:var(--white-dim);">👋 <strong style="color:var(--white)">Door greeting</strong> — learn every student's name and greet them personally</div>
          <div style="background:rgba(155,89,182,0.1);border-radius:8px;padding:10px 14px;font-size:13px;color:var(--white-dim);">🤝 <strong style="color:var(--white)">Peer connection</strong> — structured partner and small-group activities</div>
          <div style="background:rgba(155,89,182,0.1);border-radius:8px;padding:10px 14px;font-size:13px;color:var(--white-dim);">🎙️ <strong style="color:var(--white)">Student voice</strong> — create regular opportunities for students to be genuinely heard</div>
        </div>
      </div>

      <!-- M -->
      <div style="background:rgba(39,174,96,0.06);border:1px solid rgba(39,174,96,0.2);border-left:4px solid var(--m);border-radius:var(--radius);padding:24px 28px;" id="sec-m">
        <div style="display:flex;align-items:center;gap:12px;margin-bottom:12px;">
          <span style="font-family:'Playfair Display',serif;font-size:28px;font-weight:900;color:var(--m);line-height:1;">M</span>
          <div>
            <div style="font-size:16px;font-weight:700;color:var(--white)">Meaning</div>
            <div style="font-size:12px;color:rgba(39,174,96,0.8);font-family:'DM Mono',monospace;">Duckworth's Purpose Research · Self-Determination Theory</div>
          </div>
        </div>
        <p style="font-size:14px;color:var(--white-dim);margin-bottom:14px;line-height:1.7;">Meaning comes from contributing to something beyond ourselves. For adolescents, finding purpose — even in small ways — buffers against anxiety and depression and sustains motivation far more reliably than external rewards. Research shows that students who see their work as meaningful set higher goals, persist longer, and perform better academically.</p>
        <div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(200px,1fr));gap:8px;">
          <div style="background:rgba(39,174,96,0.1);border-radius:8px;padding:10px 14px;font-size:13px;color:var(--white-dim);">🌍 <strong style="color:var(--white)">"Why does this matter?"</strong> — explicitly connect content to real-world issues</div>
          <div style="background:rgba(39,174,96,0.1);border-radius:8px;padding:10px 14px;font-size:13px;color:var(--white-dim);">🫱 <strong style="color:var(--white)">Service learning</strong> — projects that contribute to the school or community</div>
          <div style="background:rgba(39,174,96,0.1);border-radius:8px;padding:10px 14px;font-size:13px;color:var(--white-dim);">🧭 <strong style="color:var(--white)">Future links</strong> — connect learning to students' own values and aspirations</div>
        </div>
      </div>

      <!-- A -->
      <div style="background:rgba(243,156,18,0.06);border:1px solid rgba(243,156,18,0.2);border-left:4px solid var(--a);border-radius:var(--radius);padding:24px 28px;" id="sec-a">
        <div style="display:flex;align-items:center;gap:12px;margin-bottom:12px;">
          <span style="font-family:'Playfair Display',serif;font-size:28px;font-weight:900;color:var(--a);line-height:1;">A</span>
          <div>
            <div style="font-size:16px;font-weight:700;color:var(--white)">Accomplishment</div>
            <div style="font-size:12px;color:rgba(243,156,18,0.8);font-family:'DM Mono',monospace;">Dweck's Growth Mindset · Duckworth's Grit · WOOP Goals</div>
          </div>
        </div>
        <p style="font-size:14px;color:var(--white-dim);margin-bottom:14px;line-height:1.7;">Accomplishment isn't just about winning — it's about pursuing goals with effort and persistence. Dweck's research shows students with a growth mindset outperform peers with equal ability. Duckworth's grit research shows passion and perseverance predict success beyond talent alone. WOOP goal-setting (Wish, Outcome, Obstacle, Plan) is more effective than SMART goals because it requires students to anticipate and plan for obstacles.</p>
        <div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(200px,1fr));gap:8px;">
          <div style="background:rgba(243,156,18,0.1);border-radius:8px;padding:10px 14px;font-size:13px;color:var(--white-dim);">🌱 <strong style="color:var(--white)">"Not yet" language</strong> — reframe failure as a point on a learning journey</div>
          <div style="background:rgba(243,156,18,0.1);border-radius:8px;padding:10px 14px;font-size:13px;color:var(--white-dim);">🎯 <strong style="color:var(--white)">WOOP goals</strong> — help students set goals that include obstacle planning</div>
          <div style="background:rgba(243,156,18,0.1);border-radius:8px;padding:10px 14px;font-size:13px;color:var(--white-dim);">📣 <strong style="color:var(--white)">Effort praise</strong> — praise strategy and effort, never raw intelligence</div>
        </div>
      </div>

      <!-- H -->
      <div style="background:rgba(22,160,133,0.06);border:1px solid rgba(22,160,133,0.2);border-left:4px solid var(--h);border-radius:var(--radius);padding:24px 28px;" id="sec-h">
        <div style="display:flex;align-items:center;gap:12px;margin-bottom:12px;">
          <span style="font-family:'Playfair Display',serif;font-size:28px;font-weight:900;color:var(--h);line-height:1;">H</span>
          <div>
            <div style="font-size:16px;font-weight:700;color:var(--white)">Health</div>
            <div style="font-size:12px;color:rgba(22,160,133,0.8);font-family:'DM Mono',monospace;">Sleep · Movement · Nutrition · BDNF</div>
          </div>
        </div>
        <p style="font-size:14px;color:var(--white-dim);margin-bottom:14px;line-height:1.7;">Physical health is the foundation all other pillars rest on. Exercise increases BDNF — sometimes called "Miracle-Gro for the brain" — improving memory, attention, and mood. Adolescents need 8–10 hours of sleep; most get significantly less, with direct consequences for emotional regulation and learning. Even brief movement breaks during lessons measurably improve focus.</p>
        <div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(200px,1fr));gap:8px;">
          <div style="background:rgba(22,160,133,0.1);border-radius:8px;padding:10px 14px;font-size:13px;color:var(--white-dim);">🏃 <strong style="color:var(--white)">Movement breaks</strong> — 3–5 minutes of activity between focus periods</div>
          <div style="background:rgba(22,160,133,0.1);border-radius:8px;padding:10px 14px;font-size:13px;color:var(--white-dim);">😴 <strong style="color:var(--white)">Sleep literacy</strong> — normalise conversations about sleep and its impact on learning</div>
          <div style="background:rgba(22,160,133,0.1);border-radius:8px;padding:10px 14px;font-size:13px;color:var(--white-dim);">🌬️ <strong style="color:var(--white)">Breathing exercises</strong> — even 2 minutes of box breathing reduces cortisol</div>
        </div>
      </div>

    </div>
  </section>

  <!-- ─── CLASSROOM APPLICATION ─── -->
  <section class="course-section" id="sec-classroom">
    <div class="section-header">
      <div class="section-number">05</div>
      <h2>PERMAH in <span>Your Classroom</span></h2>
    </div>
    <p class="lead-text">Positive Education doesn't require a new subject or a full curriculum overhaul. Small, consistent, intentional practices embedded across your teaching day make the biggest difference.</p>

    <div class="callout callout-tip">
      <span class="callout-icon">🎯</span>
      <div class="callout-body">
        <h4>Start Small, Stay Consistent</h4>
        <p>Research shows that brief, regular wellbeing practices — even 5 minutes at the start of a lesson — have a cumulative positive effect on classroom culture. Pick one pillar, embed one practice, repeat it for three weeks before adding another.</p>
      </div>
    </div>

    <div class="stats-row" style="margin-top:24px;">
      <div class="stat-card" style="border-top:3px solid var(--p)"><div class="stat-num" style="font-size:20px;color:var(--p)">P</div><div class="stat-label">3 Good Things check-in · Gratitude circle · Celebrate effort</div></div>
      <div class="stat-card" style="border-top:3px solid var(--e)"><div class="stat-num" style="font-size:20px;color:var(--e)">E</div><div class="stat-label">Strengths-based tasks · Open-ended challenge · Student choice</div></div>
      <div class="stat-card" style="border-top:3px solid var(--r)"><div class="stat-num" style="font-size:20px;color:var(--r)">R</div><div class="stat-label">Door greeting · Peer connection · Student voice</div></div>
      <div class="stat-card" style="border-top:3px solid var(--m)"><div class="stat-num" style="font-size:20px;color:var(--m)">M</div><div class="stat-label">Real-world links · Service learning · "Why does this matter?"</div></div>
      <div class="stat-card" style="border-top:3px solid var(--a)"><div class="stat-num" style="font-size:20px;color:var(--a)">A</div><div class="stat-label">WOOP goals · "Not yet" language · Forward feedback</div></div>
      <div class="stat-card" style="border-top:3px solid var(--h)"><div class="stat-num" style="font-size:20px;color:var(--h)">H</div><div class="stat-label">Movement breaks · Sleep conversations · Breathing exercises</div></div>
    </div>

    <!-- SORTING ACTIVITY -->
    <div class="activity-block" style="margin-top:32px;">
      <h3>🔀 Sort It: Which PERMAH Pillar?</h3>
      <p>Drag each classroom practice into the PERMAH pillar you think it belongs to. Some may fit multiple — choose the best match!</p>

      <div style="margin:16px 0;">
        <p style="font-size:13px;color:var(--white-dim);margin-bottom:10px;">Practices to sort:</p>
        <div id="sort-bank-chips">
          <span class="sort-chip" draggable="true" data-pillar="P">Gratitude journals</span>
          <span class="sort-chip" draggable="true" data-pillar="R">Peer mentoring pairs</span>
          <span class="sort-chip" draggable="true" data-pillar="E">Strength-based projects</span>
          <span class="sort-chip" draggable="true" data-pillar="M">Service learning</span>
          <span class="sort-chip" draggable="true" data-pillar="A">Goal-setting conferences</span>
          <span class="sort-chip" draggable="true" data-pillar="H">Brain breaks / movement</span>
        </div>
      </div>

      <div style="display:grid;grid-template-columns:repeat(3,1fr);gap:10px;margin-top:8px;" id="sort-targets">
        <div class="sort-target" data-target="P"><h4>P — Positive Emotions</h4></div>
        <div class="sort-target" data-target="E"><h4>E — Engagement</h4></div>
        <div class="sort-target" data-target="R"><h4>R — Relationships</h4></div>
        <div class="sort-target" data-target="M"><h4>M — Meaning</h4></div>
        <div class="sort-target" data-target="A"><h4>A — Accomplishment</h4></div>
        <div class="sort-target" data-target="H"><h4>H — Health</h4></div>
      </div>

      <div id="sort-result" style="display:none;margin-top:14px;padding:14px 18px;background:rgba(0,166,81,0.1);border:1px solid rgba(0,166,81,0.3);border-radius:8px;font-size:14px;color:#6ee7a0;line-height:1.6;">
        ✅ <strong>Check your answers:</strong> Gratitude journals → P, Peer mentoring → R, Strength-based projects → E, Service learning → M, Goal-setting → A, Brain breaks → H.
      </div>

      <div style="display:flex;gap:8px;margin-top:14px;flex-wrap:wrap;">
        <button class="btn btn-secondary" onclick="checkSort()">Check My Answers</button>
        <button class="btn btn-secondary" onclick="resetSort()">Reset</button>
      </div>
    </div>

    <div style="background:linear-gradient(135deg,rgba(0,92,46,0.3),rgba(0,40,20,0.2));border:1px solid rgba(0,166,81,0.3);border-radius:var(--radius);padding:24px 28px;margin-top:28px;">
      <div style="display:flex;gap:14px;align-items:flex-start;">
        <span style="font-size:28px;flex-shrink:0;">🏫</span>
        <div>
          <h4 style="font-size:15px;font-weight:700;color:var(--white);margin-bottom:8px;">Beyond the Classroom: Thinking Whole-School</h4>
          <p style="font-size:14px;color:var(--white-dim);line-height:1.7;margin-bottom:14px;">The classroom practices in this course are a powerful starting point — but research is clear that Positive Education has the greatest and most lasting impact when it operates at the <strong style="color:var(--white)">whole-school level</strong>, not just within individual classrooms. This means two things working together:</p>
          <div style="display:grid;grid-template-columns:1fr 1fr;gap:12px;margin-bottom:16px;">
            <div style="background:rgba(255,255,255,0.05);border-radius:8px;padding:14px 16px;">
              <div style="font-family:'DM Mono',monospace;font-size:10px;letter-spacing:2px;text-transform:uppercase;color:var(--gold);margin-bottom:6px;">Taught (Explicit)</div>
              <p style="font-size:13px;color:var(--white-dim);line-height:1.6;margin:0;">Dedicated time to <em>teach</em> wellbeing concepts — structured lessons, pastoral care programs, and activities like this course where the content of Positive Education is directly explained and explored.</p>
            </div>
            <div style="background:rgba(255,255,255,0.05);border-radius:8px;padding:14px 16px;">
              <div style="font-family:'DM Mono',monospace;font-size:10px;letter-spacing:2px;text-transform:uppercase;color:var(--gold);margin-bottom:6px;">Caught (Implicit)</div>
              <p style="font-size:13px;color:var(--white-dim);line-height:1.6;margin:0;">Wellbeing woven into the fabric of everyday school life — the language staff use, how assemblies are run, how behaviour is managed, and how every subject teacher <em>approaches</em> their class, not just what they teach.</p>
            </div>
          </div>
          <p style="font-size:14px;color:var(--white-dim);line-height:1.7;margin-bottom:14px;">The Geelong Grammar School model — the benchmark for whole-school Pos Ed — describes this as <strong style="color:var(--white)">Learn it → Live it → Teach it → Embed it</strong>. This course focuses on the first two stages. Talk to your leadership team about how PERMAH can be embedded school-wide at Corinda SHS.</p>
          <a href="https://www.pesa.edu.au" target="_blank" class="btn btn-secondary" style="font-size:12px;padding:7px 16px;">🔗 Explore whole-school Pos Ed with PESA</a>
        </div>
      </div>
    </div>
  </section>

  <!-- ─── TEACHER WELLBEING ─── -->
  <section class="course-section" id="sec-self">
    <div class="section-header">
      <div class="section-number">06</div>
      <h2>Your Own <span>Wellbeing Matters</span></h2>
    </div>
    <p class="lead-text">You cannot pour from an empty cup. Teacher wellbeing is not a luxury — it directly shapes classroom climate, student relationships, and your long-term effectiveness and satisfaction in the profession.</p>

    <div class="highlight-box">
      <blockquote>"The emotional climate of a classroom is largely determined by the emotional state of the teacher in the room."</blockquote>
      <cite>— John Hattie, Visible Learning</cite>
    </div>

    <div class="callout callout-tip">
      <span class="callout-icon">🌿</span>
      <div class="callout-body">
        <h4>Apply PERMAH to Yourself</h4>
        <p>The same six pillars that support students apply equally to teachers. Use the sliders below to rate your own wellbeing right now — then identify one small action you can take this week in your lowest-scoring area.</p>
      </div>
    </div>

    <div class="activity-block">
      <h3>🌿 Your PERMAH Self-Check</h3>
      <p>Rate your own wellbeing across each pillar right now (1 = struggling, 10 = thriving).</p>
      <div class="slider-group" style="margin-top:16px;">
        <div class="slider-item">
          <div class="slider-label"><span>P — I experience positive emotions regularly</span><span class="slider-value" id="ts1">5</span></div>
          <input type="range" min="1" max="10" value="5" oninput="document.getElementById('ts1').textContent=this.value">
        </div>
        <div class="slider-item">
          <div class="slider-label"><span>E — I feel engaged and absorbed in my work</span><span class="slider-value" id="ts2">5</span></div>
          <input type="range" min="1" max="10" value="5" oninput="document.getElementById('ts2').textContent=this.value">
        </div>
        <div class="slider-item">
          <div class="slider-label"><span>R — I feel supported by colleagues</span><span class="slider-value" id="ts3">5</span></div>
          <input type="range" min="1" max="10" value="5" oninput="document.getElementById('ts3').textContent=this.value">
        </div>
        <div class="slider-item">
          <div class="slider-label"><span>M — My work feels meaningful and purposeful</span><span class="slider-value" id="ts4">5</span></div>
          <input type="range" min="1" max="10" value="5" oninput="document.getElementById('ts4').textContent=this.value">
        </div>
        <div class="slider-item">
          <div class="slider-label"><span>A — I feel a sense of accomplishment at work</span><span class="slider-value" id="ts5">5</span></div>
          <input type="range" min="1" max="10" value="5" oninput="document.getElementById('ts5').textContent=this.value">
        </div>
        <div class="slider-item">
          <div class="slider-label"><span>H — I'm taking care of my physical health</span><span class="slider-value" id="ts6">5</span></div>
          <input type="range" min="1" max="10" value="5" oninput="document.getElementById('ts6').textContent=this.value">
        </div>
      </div>
      <p style="font-size:13px;color:var(--white-dim);margin-top:16px;font-style:italic;">Notice which pillar scored lowest — that's your starting point. Your wellbeing is the foundation of everything else you do at school.</p>
    </div>
  </section>

  <!-- ─── RESOURCES ─── -->
  <section class="course-section" id="sec-resources">
    <div class="section-header">
      <div class="section-number">07</div>
      <h2>Further <span>Reading & Tools</span></h2>
    </div>
    <p class="lead-text">Here are the key organisations, tools, and resources to support your ongoing practice — all free to access.</p>

    <div class="resource-grid">
      <a class="resource-card" href="https://www.pesa.edu.au" target="_blank">
        <span class="res-icon">🌟</span>
        <div class="res-content">
          <h4>PESA — Positive Education Schools Association</h4>
          <p>Australia's leading Positive Education body. Research, conferences, PERMAH survey, and school support.</p>
          <div class="res-type">🔗 Website</div>
        </div>
      </a>
      <a class="resource-card" href="https://www.viacharacter.org" target="_blank">
        <span class="res-icon">💪</span>
        <div class="res-content">
          <h4>VIA Institute on Character</h4>
          <p>Free character strengths survey for adults and youth. Essential for the Engagement pillar.</p>
          <div class="res-type">🔗 Free Survey</div>
        </div>
      </a>
      <a class="resource-card" href="https://www.authentichappiness.sas.upenn.edu" target="_blank">
        <span class="res-icon">🎓</span>
        <div class="res-content">
          <h4>Authentic Happiness — Seligman/UPenn</h4>
          <p>Free questionnaires and tools including the original PERMA Profiler self-assessment.</p>
          <div class="res-type">🔗 Free Tools</div>
        </div>
      </a>
      <a class="resource-card" href="https://www.woopmylife.org" target="_blank">
        <span class="res-icon">🎯</span>
        <div class="res-content">
          <h4>WOOP My Life</h4>
          <p>Free WOOP goal-setting app. Great for Accomplishment activities with students.</p>
          <div class="res-type">🔗 Free Tool</div>
        </div>
      </a>
      <a class="resource-card" href="https://mindmatters.edu.au" target="_blank">
        <span class="res-icon">🧠</span>
        <div class="res-content">
          <h4>MindMatters</h4>
          <p>Free Australian government-funded mental health and wellbeing programs for secondary schools.</p>
          <div class="res-type">🔗 Free Programs</div>
        </div>
      </a>
      <a class="resource-card" href="https://positivepsychology.com/positive-education/" target="_blank">
        <span class="res-icon">📖</span>
        <div class="res-content">
          <h4>Positive Psychology.com</h4>
          <p>Lesson plans, worksheets, and research summaries. Key books: <em>Flourish</em> (Seligman), <em>Mindset</em> (Dweck), <em>Grit</em> (Duckworth).</p>
          <div class="res-type">🔗 Resource Hub</div>
        </div>
      </a>
    </div>

    <!-- COMPLETION BLOCK -->
    <div style="background:linear-gradient(135deg,rgba(0,166,81,0.15),rgba(0,92,46,0.1));border:1px solid rgba(0,166,81,0.3);border-radius:16px;padding:40px;text-align:center;margin-top:40px;">
      <div style="font-size:48px;margin-bottom:16px;">📝</div>
      <h2 style="font-family:'Playfair Display',serif;font-size:28px;color:var(--white);margin-bottom:12px;">Ready for Your Certificate?</h2>
      <p style="color:var(--white-dim);max-width:480px;margin:0 auto 24px;font-size:15px;">You've explored all seven modules. Complete the final assessment below to receive your certificate of completion.</p>
      <div style="display:flex;gap:12px;justify-content:center;flex-wrap:wrap;">
        <a href="#sec-assessment" class="btn btn-primary" onclick="document.getElementById('sec-assessment').scrollIntoView({behavior:'smooth'});return false;">Take the Assessment ↓</a>
        <button class="btn btn-secondary" onclick="window.scrollTo({top:0,behavior:'smooth'})">↑ Back to Top</button>
      </div>
    </div>
  </section>

  <!-- ─── APST ALIGNMENT ─── -->
  <section class="course-section" id="sec-apst">
    <div class="section-header">
      <div class="section-number">07b</div>
      <h2>APST <span>Standards Alignment</span></h2>
    </div>
    <p class="lead-text">This professional learning course addresses five of the seven <strong style="color:var(--white)">Australian Professional Standards for Teachers (APST)</strong> — the national framework that defines what teachers should know and be able to do at every career stage.</p>

    <div class="callout callout-info">
      <span class="callout-icon">🏛️</span>
      <div class="callout-body">
        <h4>About the APST</h4>
        <p>The Australian Professional Standards for Teachers are published by AITSL (Australian Institute for Teaching and School Leadership) and are organised across three domains — Professional Knowledge, Professional Practice, and Professional Engagement — with seven standards total. Completing this course contributes evidence toward the Proficient, Highly Accomplished, and Lead career stages.</p>
      </div>
    </div>

    <!-- All 7 standards — applicable ones highlighted -->
    <div style="display:flex;flex-direction:column;gap:14px;margin:32px 0;">

      <!-- Domain label -->
      <div style="font-family:'DM Mono',monospace;font-size:10px;letter-spacing:3px;text-transform:uppercase;color:var(--gold);opacity:0.7;padding:4px 0 2px;">Professional Knowledge</div>

      <div class="apst-card apst-applicable" data-std="1">
        <div class="apst-badge applicable">✓ Applicable</div>
        <div class="apst-num">Standard 1</div>
        <div class="apst-title">Know students and how they learn</div>
        <div class="apst-body">
          <p>This course directly addresses how students learn and what supports their engagement, motivation, and wellbeing. The PERMAH framework deepens teachers' understanding of the psychological and physical factors — including emotion, relationships, meaning, and health — that influence how effectively students learn.</p>
          <div class="apst-focus-areas">
            <span class="apst-tag">1.1 Physical, social & intellectual development</span>
            <span class="apst-tag">1.2 Understanding how students learn</span>
            <span class="apst-tag">1.3 Students with diverse linguistic, cultural & religious backgrounds</span>
          </div>
        </div>
      </div>

      <div class="apst-card apst-not-applicable" data-std="2">
        <div class="apst-badge not-applicable">— Not applicable</div>
        <div class="apst-num">Standard 2</div>
        <div class="apst-title">Know the content and how to teach it</div>
        <div class="apst-body">
          <p>This standard relates to subject-specific curriculum knowledge and pedagogy. While Positive Education informs how you teach, this course does not address specific learning area content or curriculum knowledge.</p>
        </div>
      </div>

      <div style="font-family:'DM Mono',monospace;font-size:10px;letter-spacing:3px;text-transform:uppercase;color:var(--gold);opacity:0.7;padding:12px 0 2px;">Professional Practice</div>

      <div class="apst-card apst-applicable" data-std="3">
        <div class="apst-badge applicable">✓ Applicable</div>
        <div class="apst-num">Standard 3</div>
        <div class="apst-title">Plan for and implement effective teaching and learning</div>
        <div class="apst-body">
          <p>The course provides practical, evidence-based strategies for planning lessons and units that incorporate student wellbeing, strengths-based approaches, goal-setting (WOOP), engagement through flow theory, and meaningful learning experiences — all of which strengthen teaching and learning planning.</p>
          <div class="apst-focus-areas">
            <span class="apst-tag">3.1 Establish challenging learning goals</span>
            <span class="apst-tag">3.3 Use teaching strategies</span>
            <span class="apst-tag">3.4 Select and use resources</span>
          </div>
        </div>
      </div>

      <div class="apst-card apst-applicable" data-std="4">
        <div class="apst-badge applicable">✓ Applicable</div>
        <div class="apst-num">Standard 4</div>
        <div class="apst-title">Create and maintain supportive and safe learning environments</div>
        <div class="apst-body">
          <p>This is the most directly addressed standard in the course. The R (Relationships), P (Positive Emotions), and H (Health) pillars all contribute to creating physically and emotionally safe, supportive classroom environments. Content on classroom climate, student connection, and teacher-student relationships maps directly to this standard.</p>
          <div class="apst-focus-areas">
            <span class="apst-tag">4.1 Support student participation</span>
            <span class="apst-tag">4.2 Manage classroom activities</span>
            <span class="apst-tag">4.4 Maintain student safety</span>
          </div>
        </div>
      </div>

      <div class="apst-card apst-not-applicable" data-std="5">
        <div class="apst-badge not-applicable">— Not applicable</div>
        <div class="apst-num">Standard 5</div>
        <div class="apst-title">Assess, provide feedback and report on student learning</div>
        <div class="apst-body">
          <p>While growth mindset feedback principles are discussed briefly, this course does not specifically address formal assessment design, reporting practices, or feedback frameworks. A dedicated assessment literacy course would address this standard more fully.</p>
        </div>
      </div>

      <div style="font-family:'DM Mono',monospace;font-size:10px;letter-spacing:3px;text-transform:uppercase;color:var(--gold);opacity:0.7;padding:12px 0 2px;">Professional Engagement</div>

      <div class="apst-card apst-applicable" data-std="6">
        <div class="apst-badge applicable">✓ Applicable</div>
        <div class="apst-num">Standard 6</div>
        <div class="apst-title">Engage in professional learning</div>
        <div class="apst-body">
          <p>Completing this self-paced professional learning course is itself evidence of Standard 6. The course includes self-assessment activities, reflection prompts, a personal PERMAH wellbeing audit, and application planning — all of which demonstrate engagement in data-informed professional learning.</p>
          <div class="apst-focus-areas">
            <span class="apst-tag">6.1 Identify and plan for professional learning</span>
            <span class="apst-tag">6.2 Engage in professional learning and improve practice</span>
            <span class="apst-tag">6.3 Engage with and mentor colleagues</span>
            <span class="apst-tag">6.4 Apply professional learning and improve student learning</span>
          </div>
        </div>
      </div>

      <div class="apst-card apst-applicable" data-std="7">
        <div class="apst-badge applicable">✓ Applicable</div>
        <div class="apst-num">Standard 7</div>
        <div class="apst-title">Engage professionally with colleagues, parents/carers and the community</div>
        <div class="apst-body">
          <p>The course's focus on school-wide Positive Education, Housemaster and student services practice, teacher collaboration on wellbeing, and communicating with parents and carers about student flourishing all align with this standard.</p>
          <div class="apst-focus-areas">
            <span class="apst-tag">7.1 Meet professional ethics and responsibilities</span>
            <span class="apst-tag">7.3 Engage with the parents/carers</span>
            <span class="apst-tag">7.4 Engage with professional teaching networks</span>
          </div>
        </div>
      </div>

    </div>

    <!-- Summary strip -->
    <div style="background:var(--gold-dim);border:1px solid rgba(242,180,0,0.3);border-radius:var(--radius);padding:24px 28px;display:flex;align-items:center;gap:20px;flex-wrap:wrap;margin-top:8px;">
      <div style="font-size:32px;">📋</div>
      <div>
        <div style="font-family:'DM Mono',monospace;font-size:10px;letter-spacing:2px;text-transform:uppercase;color:var(--gold);margin-bottom:4px;">Course APST Alignment Summary</div>
        <div style="font-size:14px;color:var(--white);">Standards addressed: <strong style="color:var(--gold)">1, 3, 4, 6, 7</strong> &nbsp;·&nbsp; Standards not addressed: <span style="color:var(--white-dim)">2, 5</span></div>
        <div style="font-size:13px;color:var(--white-dim);margin-top:4px;">These standard numbers will appear on your certificate of completion.</div>
      </div>
    </div>

  </section>

  <!-- ─── FINAL ASSESSMENT ─── -->
  <section class="course-section" id="sec-assessment">
    <div class="section-header">
      <div class="section-number">08</div>
      <h2>Final <span>Assessment</span></h2>
    </div>
    <p class="lead-text">Answer all 10 questions to demonstrate your understanding of Positive Education and the PERMAH framework. You need <strong style="color:var(--gold)">8 out of 10 (80%)</strong> to pass and receive your certificate. You may attempt this as many times as you need.</p>

    <div class="callout callout-tip">
      <span class="callout-icon">💡</span>
      <div class="callout-body">
        <h4>Before you begin</h4>
        <p>Enter your name as you'd like it to appear on your certificate, then work through all 10 questions. Your result will be shown immediately and your certificate generated automatically on passing.</p>
      </div>
    </div>

    <!-- NAME ENTRY -->
    <div style="margin:28px 0 32px;">
      <label style="display:block;font-size:14px;font-weight:600;color:var(--white);margin-bottom:8px;">Your Full Name (for certificate)</label>
      <input type="text" id="cert-name" placeholder="e.g. Sarah Johnson" style="width:100%;max-width:420px;background:rgba(255,255,255,0.05);border:1px solid rgba(255,255,255,0.2);border-radius:8px;padding:12px 16px;color:var(--white);font-family:'DM Sans',sans-serif;font-size:15px;outline:none;transition:border-color 0.2s;" onfocus="this.style.borderColor='var(--gold)'" onblur="this.style.borderColor='rgba(255,255,255,0.2)'">
      <label style="display:block;font-size:14px;font-weight:600;color:var(--white);margin-bottom:8px;margin-top:16px;">Your House</label>
      <select id="cert-house" style="width:100%;max-width:420px;background:rgba(255,255,255,0.05);border:1px solid rgba(255,255,255,0.2);border-radius:8px;padding:12px 16px;color:var(--white);font-family:'DM Sans',sans-serif;font-size:15px;outline:none;transition:border-color 0.2s;cursor:pointer;appearance:none;-webkit-appearance:none;background-image:url(&quot;data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='8' viewBox='0 0 12 8'%3E%3Cpath fill='%23f2b400' d='M1 1l5 5 5-5'/%3E%3C/svg%3E&quot;);background-repeat:no-repeat;background-position:right 14px center;" onfocus="this.style.borderColor='var(--gold)'" onblur="this.style.borderColor='rgba(255,255,255,0.2)'">
        <option value="" disabled selected>Select your house…</option>
        <option value="Bunar">Bunar</option>
        <option value="Dibbil">Dibbil</option>
        <option value="Kabul">Kabul</option>
        <option value="Moori">Moori</option>
        <option value="Pirri">Pirri</option>
        <option value="Yarraman">Yarraman</option>
      </select>

      <label style="display:block;font-size:14px;font-weight:600;color:var(--white);margin-bottom:8px;margin-top:16px;">Your Role / School (optional)</label>
      <input type="text" id="cert-role" placeholder="e.g. Science Teacher, Corinda SHS" style="width:100%;max-width:420px;background:rgba(255,255,255,0.05);border:1px solid rgba(255,255,255,0.2);border-radius:8px;padding:12px 16px;color:var(--white);font-family:'DM Sans',sans-serif;font-size:15px;outline:none;transition:border-color 0.2s;" onfocus="this.style.borderColor='var(--gold)'" onblur="this.style.borderColor='rgba(255,255,255,0.2)'">
    </div>

    <!-- ASSESSMENT QUESTIONS -->
    <div id="assessment-form">

      <div class="assessment-q" data-correct="B">
        <div class="aq-header"><span class="aq-num">Q1</span><span class="aq-text">Which researcher developed the PERMA model that underpins Positive Education?</span></div>
        <div class="aq-options">
          <label class="aq-opt"><input type="radio" name="aq1" value="A"><span class="aq-opt-text">Carol Dweck</span></label>
          <label class="aq-opt"><input type="radio" name="aq1" value="B"><span class="aq-opt-text">Martin Seligman</span></label>
          <label class="aq-opt"><input type="radio" name="aq1" value="C"><span class="aq-opt-text">Barbara Fredrickson</span></label>
          <label class="aq-opt"><input type="radio" name="aq1" value="D"><span class="aq-opt-text">Angela Duckworth</span></label>
        </div>
        <div class="aq-feedback"></div>
      </div>

      <div class="assessment-q" data-correct="C">
        <div class="aq-header"><span class="aq-num">Q2</span><span class="aq-text">What does the "H" stand for in the PERMAH framework?</span></div>
        <div class="aq-options">
          <label class="aq-opt"><input type="radio" name="aq2" value="A"><span class="aq-opt-text">Happiness</span></label>
          <label class="aq-opt"><input type="radio" name="aq2" value="B"><span class="aq-opt-text">Harmony</span></label>
          <label class="aq-opt"><input type="radio" name="aq2" value="C"><span class="aq-opt-text">Health</span></label>
          <label class="aq-opt"><input type="radio" name="aq2" value="D"><span class="aq-opt-text">Hope</span></label>
        </div>
        <div class="aq-feedback"></div>
      </div>

      <div class="assessment-q" data-correct="A">
        <div class="aq-header"><span class="aq-num">Q3</span><span class="aq-text">Barbara Fredrickson's "Broaden-and-Build Theory" proposes that positive emotions:</span></div>
        <div class="aq-options">
          <label class="aq-opt"><input type="radio" name="aq3" value="A"><span class="aq-opt-text">Expand our thinking and help build lasting psychological and social resources</span></label>
          <label class="aq-opt"><input type="radio" name="aq3" value="B"><span class="aq-opt-text">Replace negative emotions permanently with practice</span></label>
          <label class="aq-opt"><input type="radio" name="aq3" value="C"><span class="aq-opt-text">Are less important than eliminating negative emotions</span></label>
          <label class="aq-opt"><input type="radio" name="aq3" value="D"><span class="aq-opt-text">Only benefit people who are already high in wellbeing</span></label>
        </div>
        <div class="aq-feedback"></div>
      </div>

      <div class="assessment-q" data-correct="D">
        <div class="aq-header"><span class="aq-num">Q4</span><span class="aq-text">In Csikszentmihalyi's concept of "flow," which condition is most important?</span></div>
        <div class="aq-options">
          <label class="aq-opt"><input type="radio" name="aq4" value="A"><span class="aq-opt-text">The task must be easy and stress-free</span></label>
          <label class="aq-opt"><input type="radio" name="aq4" value="B"><span class="aq-opt-text">The activity must involve social interaction</span></label>
          <label class="aq-opt"><input type="radio" name="aq4" value="C"><span class="aq-opt-text">The learner must be externally rewarded</span></label>
          <label class="aq-opt"><input type="radio" name="aq4" value="D"><span class="aq-opt-text">Challenge and skill are well-matched — stretched but capable</span></label>
        </div>
        <div class="aq-feedback"></div>
      </div>

      <div class="assessment-q" data-correct="B">
        <div class="aq-header"><span class="aq-num">Q5</span><span class="aq-text">Which of the following is the BEST example of an "Accomplishment" (A) strategy in the classroom?</span></div>
        <div class="aq-options">
          <label class="aq-opt"><input type="radio" name="aq5" value="A"><span class="aq-opt-text">Starting class with a gratitude circle</span></label>
          <label class="aq-opt"><input type="radio" name="aq5" value="B"><span class="aq-opt-text">Teaching students to use WOOP to set and pursue meaningful goals</span></label>
          <label class="aq-opt"><input type="radio" name="aq5" value="C"><span class="aq-opt-text">Assigning students to work in pairs for every activity</span></label>
          <label class="aq-opt"><input type="radio" name="aq5" value="D"><span class="aq-opt-text">Connecting content to real-world community problems</span></label>
        </div>
        <div class="aq-feedback"></div>
      </div>

      <div class="assessment-q" data-correct="C">
        <div class="aq-header"><span class="aq-num">Q6</span><span class="aq-text">According to John Hattie's Visible Learning research, the teacher-student relationship is:</span></div>
        <div class="aq-options">
          <label class="aq-opt"><input type="radio" name="aq6" value="A"><span class="aq-opt-text">Less important than curriculum quality</span></label>
          <label class="aq-opt"><input type="radio" name="aq6" value="B"><span class="aq-opt-text">Only significant for students with learning difficulties</span></label>
          <label class="aq-opt"><input type="radio" name="aq6" value="C"><span class="aq-opt-text">One of the highest-impact factors for student achievement</span></label>
          <label class="aq-opt"><input type="radio" name="aq6" value="D"><span class="aq-opt-text">Important for wellbeing but unrelated to academic performance</span></label>
        </div>
        <div class="aq-feedback"></div>
      </div>

      <div class="assessment-q" data-correct="A">
        <div class="aq-header"><span class="aq-num">Q7</span><span class="aq-text">The VIA Character Strengths survey is most closely linked to which PERMAH pillar?</span></div>
        <div class="aq-options">
          <label class="aq-opt"><input type="radio" name="aq7" value="A"><span class="aq-opt-text">Engagement (E)</span></label>
          <label class="aq-opt"><input type="radio" name="aq7" value="B"><span class="aq-opt-text">Meaning (M)</span></label>
          <label class="aq-opt"><input type="radio" name="aq7" value="C"><span class="aq-opt-text">Accomplishment (A)</span></label>
          <label class="aq-opt"><input type="radio" name="aq7" value="D"><span class="aq-opt-text">Positive Emotions (P)</span></label>
        </div>
        <div class="aq-feedback"></div>
      </div>

      <div class="assessment-q" data-correct="D">
        <div class="aq-header"><span class="aq-num">Q8</span><span class="aq-text">Which of the following best describes the role of "Meaning" (M) in the PERMAH framework?</span></div>
        <div class="aq-options">
          <label class="aq-opt"><input type="radio" name="aq8" value="A"><span class="aq-opt-text">Achieving high academic results and awards</span></label>
          <label class="aq-opt"><input type="radio" name="aq8" value="B"><span class="aq-opt-text">Feeling physically healthy and energetic</span></label>
          <label class="aq-opt"><input type="radio" name="aq8" value="C"><span class="aq-opt-text">Having strong friendships with peers</span></label>
          <label class="aq-opt"><input type="radio" name="aq8" value="D"><span class="aq-opt-text">Belonging to and serving something bigger than yourself</span></label>
        </div>
        <div class="aq-feedback"></div>
      </div>

      <div class="assessment-q" data-correct="B">
        <div class="aq-header"><span class="aq-num">Q9</span><span class="aq-text">Positive Education was first implemented as a whole-school model at:</span></div>
        <div class="aq-options">
          <label class="aq-opt"><input type="radio" name="aq9" value="A"><span class="aq-opt-text">Harvard University's education faculty</span></label>
          <label class="aq-opt"><input type="radio" name="aq9" value="B"><span class="aq-opt-text">Geelong Grammar School, Australia</span></label>
          <label class="aq-opt"><input type="radio" name="aq9" value="C"><span class="aq-opt-text">Wellington College, England</span></label>
          <label class="aq-opt"><input type="radio" name="aq9" value="D"><span class="aq-opt-text">The University of Pennsylvania</span></label>
        </div>
        <div class="aq-feedback"></div>
      </div>

      <div class="assessment-q" data-correct="C">
        <div class="aq-header"><span class="aq-num">Q10</span><span class="aq-text">A teacher who says "You haven't mastered this yet" is actively modelling which concept?</span></div>
        <div class="aq-options">
          <label class="aq-opt"><input type="radio" name="aq10" value="A"><span class="aq-opt-text">Flow theory</span></label>
          <label class="aq-opt"><input type="radio" name="aq10" value="B"><span class="aq-opt-text">Broaden-and-Build Theory</span></label>
          <label class="aq-opt"><input type="radio" name="aq10" value="C"><span class="aq-opt-text">Growth Mindset</span></label>
          <label class="aq-opt"><input type="radio" name="aq10" value="D"><span class="aq-opt-text">Grit and perseverance</span></label>
        </div>
        <div class="aq-feedback"></div>
      </div>

      <div id="aq-error" style="display:none;color:#fca5a5;font-size:14px;margin-bottom:12px;padding:12px 16px;background:rgba(232,93,74,0.1);border:1px solid rgba(232,93,74,0.3);border-radius:8px;"></div>

      <button class="btn btn-primary" style="margin-top:8px;font-size:16px;padding:14px 32px;" onclick="submitAssessment()">Submit Assessment →</button>

    </div><!-- /assessment-form -->

    <!-- RESULT BLOCK (hidden until submission) -->
    <div id="aq-result" style="display:none;margin-top:32px;"></div>

  </section>

</div><!-- /main -->

<!-- ─── CERTIFICATE MODAL ─── -->
<div id="cert-modal" style="display:none;position:fixed;inset:0;z-index:2000;background:rgba(0,10,5,0.92);backdrop-filter:blur(8px);overflow-y:auto;padding:40px 20px;">
  <div style="max-width:760px;margin:0 auto;position:relative;">
    <button onclick="closeCert()" style="position:absolute;top:-10px;right:0;background:rgba(255,255,255,0.1);border:1px solid rgba(255,255,255,0.2);color:var(--white);border-radius:8px;padding:8px 16px;cursor:pointer;font-size:13px;font-family:'DM Sans',sans-serif;">✕ Close</button>

    <!-- CERTIFICATE CANVAS -->
    <canvas id="cert-canvas" width="1056" height="900" style="width:100%;border-radius:12px;box-shadow:0 20px 60px rgba(0,0,0,0.8);margin-top:16px;"></canvas>

    <div style="display:flex;gap:12px;justify-content:center;margin-top:20px;flex-wrap:wrap;">
      <button class="btn btn-primary" onclick="downloadCert()">⬇ Download Certificate (PNG)</button>
      <button class="btn btn-secondary" onclick="closeCert()">Close</button>
    </div>
    <p style="text-align:center;font-size:12px;color:var(--white-dim);opacity:0.5;margin-top:12px;">Right-click the certificate and choose "Save image as" if the download button doesn't work in your browser.</p>
  </div>
</div>

<script>
// ─── SCROLL PROGRESS BAR ───
window.addEventListener('scroll', () => {
  const scrollTop = window.scrollY;
  const docHeight = document.documentElement.scrollHeight - window.innerHeight;
  const pct = (scrollTop / docHeight) * 100;
  document.getElementById('progress-bar').style.width = pct + '%';
});

// ─── SECTION REVEAL ───
const observer = new IntersectionObserver((entries) => {
  entries.forEach(entry => {
    if (entry.isIntersecting) entry.target.classList.add('visible');
  });
}, { threshold: 0.05 });

document.querySelectorAll('.course-section').forEach(s => observer.observe(s));

// ─── SIDEBAR ACTIVE LINK ───
const sectionIds = ['sec-what','sec-why','sec-permah','sec-p','sec-classroom','sec-self','sec-resources','sec-apst','sec-assessment'];
const navLinks = document.querySelectorAll('#nav-list a');

window.addEventListener('scroll', () => {
  let current = '';
  sectionIds.forEach(id => {
    const el = document.getElementById(id);
    if (el && window.scrollY >= el.offsetTop - 100) current = id;
  });
  navLinks.forEach(a => {
    a.classList.remove('active');
    if (a.getAttribute('href') === '#' + current) a.classList.add('active');
  });
});

// ─── ACCORDION ───
function toggleAccordion(header) {
  const body = header.nextElementSibling;
  const isOpen = body.classList.contains('open');
  header.closest('.accordion').querySelectorAll('.accordion-body.open').forEach(b => {
    b.classList.remove('open');
    b.previousElementSibling.classList.remove('open');
  });
  if (!isOpen) {
    body.classList.add('open');
    header.classList.add('open');
  }
}

// ─── QUIZ ───
const quizFeedback = {
  q1: { correct: "Correct! Positive Education is about intentionally building wellbeing skills — not toxic positivity or replacing academic learning.", incorrect: "Not quite. Positive Education adds an intentional focus on wellbeing alongside academics — it's not about avoiding difficulty." },
  q2: { correct: "Correct! Research consistently shows teacher wellbeing correlates with stronger student relationships, better classroom climate, and higher achievement.", incorrect: "The research actually shows teacher wellbeing has a direct positive impact on student outcomes. Try again!" },
  fq1: { correct: "Correct! Flow — the state of deep absorption in a challenging task — is central to the Engagement (E) pillar.", incorrect: "Flow is specifically about Engagement (E) — being fully absorbed in a task at the edge of your abilities." },
  fq2: { correct: "Correct! Barbara Fredrickson developed Broaden-and-Build Theory, showing positive emotions expand our thinking and build resources over time.", incorrect: "Broaden-and-Build was developed by Barbara Fredrickson, not Seligman (PERMA), Dweck (Growth Mindset), or Duckworth (Grit)." },
  fq3: { correct: "Correct! Health was added later (PERMA → PERMAH). Seligman's original model included Positive Emotions, Engagement, Relationships, Meaning, and Accomplishment.", incorrect: "All of those were in the original PERMA model. Health (H) was the pillar added later to create PERMAH." },
  fq4: { correct: "Correct! WOOP includes an Obstacle and Plan step — this mental contrasting helps people anticipate and overcome barriers to their goals.", incorrect: "The key advantage of WOOP is the obstacle and implementation planning stage, which research shows significantly improves goal attainment." }
};

function answerQuiz(btn, isCorrect, qId) {
  const opts = btn.closest('.quiz-options').querySelectorAll('.quiz-option');
  opts.forEach(o => o.classList.add('disabled'));
  btn.classList.add(isCorrect ? 'correct' : 'incorrect');
  const fb = document.getElementById(qId + '-fb');
  fb.textContent = isCorrect ? '✅ ' + quizFeedback[qId].correct : '❌ ' + quizFeedback[qId].incorrect;
  fb.className = 'quiz-feedback show ' + (isCorrect ? 'correct-fb' : 'incorrect-fb');
}

// ─── CHECKLIST ───
function toggleCheck(box) {
  box.classList.toggle('checked');
  box.textContent = box.classList.contains('checked') ? '✓' : '';
}

// ─── SORT ACTIVITY ───
let dragChip = null;

function initDrag() {
  document.querySelectorAll('.sort-chip').forEach(chip => {
    chip.addEventListener('dragstart', e => {
      dragChip = chip;
      chip.classList.add('dragging');
    });
    chip.addEventListener('dragend', () => chip.classList.remove('dragging'));
  });
  document.querySelectorAll('.sort-target').forEach(target => {
    target.addEventListener('dragover', e => e.preventDefault());
    target.addEventListener('drop', () => {
      if (dragChip) {
        target.appendChild(dragChip);
        dragChip.classList.add('placed');
        checkAllPlaced();
      }
    });
  });
}

function checkAllPlaced() {
  const allChips = document.querySelectorAll('.sort-chip');
  const allPlaced = [...allChips].every(c => c.closest('.sort-target'));
  if (allPlaced) {
    document.getElementById('sort-result').style.display = 'block';
  }
}

function checkSort() {
  document.getElementById('sort-result').style.display = 'block';
  document.getElementById('sort-result').scrollIntoView({behavior:'smooth', block:'nearest'});
}

function resetSort() {
  const bank = document.getElementById('sort-bank-chips');
  document.querySelectorAll('.sort-chip').forEach(c => {
    c.classList.remove('placed');
    bank.appendChild(c);
  });
  document.getElementById('sort-result').style.display = 'none';
}

initDrag();

// ─── SAVE PLAN ───
function savePlan() {
  document.getElementById('plan-saved').style.display = 'block';
  setTimeout(() => document.getElementById('plan-saved').style.opacity = '0.5', 3000);
}

// ─── SMOOTH SCROLL ───
function scrollTo(id) {
  const el = document.querySelector(id);
  if (el) el.scrollIntoView({behavior:'smooth'});
}

// ─── ASSESSMENT ───
const assessmentAnswers = {
  aq1: { correct: 'B', explanation: 'Martin Seligman developed the PERMA model at the University of Pennsylvania, forming the foundation of Positive Education.' },
  aq2: { correct: 'C', explanation: 'H stands for Health — added to Seligman\'s original PERMA to create PERMAH, recognising the role of physical wellbeing.' },
  aq3: { correct: 'A', explanation: 'Broaden-and-Build Theory shows positive emotions expand our thought-action repertoires and build lasting psychological, social and physical resources.' },
  aq4: { correct: 'D', explanation: 'Flow occurs at the intersection of high challenge and high skill — the learner is stretched but capable, creating deep absorption.' },
  aq5: { correct: 'B', explanation: 'WOOP goal-setting directly targets the Accomplishment pillar by helping students set and pursue meaningful goals with obstacle planning.' },
  aq6: { correct: 'C', explanation: 'Hattie\'s meta-analysis of 800,000+ studies placed teacher-student relationships among the highest-impact factors for achievement.' },
  aq7: { correct: 'A', explanation: 'VIA Character Strengths are central to Engagement — when students use their strengths they experience more flow, energy, and absorption.' },
  aq8: { correct: 'D', explanation: 'Meaning is about belonging to and serving something beyond yourself — having purpose, values and a sense of contribution.' },
  aq9: { correct: 'B', explanation: 'Geelong Grammar School partnered with Seligman\'s team in 2009 to become the first school globally to implement whole-school Positive Education.' },
  aq10: { correct: 'C', explanation: 'The word "yet" is a classic growth mindset language strategy from Carol Dweck\'s research — reframing inability as a point on a learning journey.' }
};

function submitAssessment() {
  const nameVal = document.getElementById('cert-name').value.trim();
  const errEl = document.getElementById('aq-error');

  if (!nameVal) {
    errEl.textContent = '⚠ Please enter your name before submitting.';
    errEl.style.display = 'block';
    document.getElementById('cert-name').focus();
    document.getElementById('cert-name').scrollIntoView({behavior:'smooth', block:'center'});
    return;
  }

  const houseVal = document.getElementById('cert-house').value;
  if (!houseVal) {
    errEl.textContent = '⚠ Please select your house before submitting.';
    errEl.style.display = 'block';
    document.getElementById('cert-house').scrollIntoView({behavior:'smooth', block:'center'});
    return;
  }

  let score = 0;
  let allAnswered = true;

  Object.keys(assessmentAnswers).forEach((qKey, idx) => {
    const qNum = idx + 1;
    const selected = document.querySelector(`input[name="${qKey}"]:checked`);
    const qEl = document.querySelectorAll('.assessment-q')[idx];
    const fbEl = qEl.querySelector('.aq-feedback');

    if (!selected) { allAnswered = false; return; }

    const { correct, explanation } = assessmentAnswers[qKey];
    const isCorrect = selected.value === correct;
    if (isCorrect) score++;

    // Lock and colour options
    qEl.classList.add('locked');
    qEl.querySelectorAll('.aq-opt').forEach(opt => {
      const val = opt.querySelector('input').value;
      if (val === correct) opt.classList.add(isCorrect ? 'correct-ans' : 'show-correct');
      else if (val === selected.value && !isCorrect) opt.classList.add('wrong-ans');
    });

    qEl.classList.add(isCorrect ? 'q-correct' : 'q-incorrect');
    fbEl.textContent = (isCorrect ? '✅ ' : '❌ ') + explanation;
    fbEl.className = 'aq-feedback show';
  });

  if (!allAnswered) {
    errEl.textContent = '⚠ Please answer all 10 questions before submitting.';
    errEl.style.display = 'block';
    return;
  }

  errEl.style.display = 'none';

  const passed = score >= 8;
  const pct = Math.round((score / 10) * 100);
  const resultEl = document.getElementById('aq-result');

  resultEl.style.display = 'block';
  resultEl.scrollIntoView({behavior:'smooth'});

  if (passed) {
    resultEl.innerHTML = `
      <div class="score-display pass">
        <div class="score-ring pass">
          <div class="score-num">${score}/10</div>
          <div class="score-denom">${pct}%</div>
        </div>
        <h2 style="font-family:'Playfair Display',serif;font-size:28px;color:#6ee7a0;margin-bottom:10px;">Congratulations, ${nameVal.split(' ')[0]}! 🎉</h2>
        <p style="color:var(--white-dim);max-width:480px;margin:0 auto 24px;font-size:15px;">You passed with ${score} out of 10 correct. Your certificate of completion is ready below.</p>
        <button class="btn btn-primary" style="font-size:15px;padding:14px 32px;" onclick="submitCompletionAndGenerate()">🏅 Generate My Certificate</button>
      </div>`;
    // Lock the submit button
    document.querySelector('#assessment-form button[onclick="submitAssessment()"]').style.display = 'none';
  } else {
    resultEl.innerHTML = `
      <div class="score-display fail">
        <div class="score-ring fail">
          <div class="score-num">${score}/10</div>
          <div class="score-denom">${pct}%</div>
        </div>
        <h2 style="font-family:'Playfair Display',serif;font-size:28px;color:#fca5a5;margin-bottom:10px;">Not quite this time</h2>
        <p style="color:var(--white-dim);max-width:480px;margin:0 auto 24px;font-size:15px;">You scored ${score} out of 10. You need 8 to pass. Review the feedback on each question above, revisit the course content, and try again — you've got this!</p>
        <button class="btn btn-secondary" style="font-size:15px;" onclick="resetAssessment()">↺ Try Again</button>
      </div>`;
  }
}

function resetAssessment() {
  document.querySelectorAll('.assessment-q').forEach(q => {
    q.classList.remove('locked','q-correct','q-incorrect');
    q.querySelectorAll('.aq-opt').forEach(o => o.classList.remove('correct-ans','wrong-ans','show-correct'));
    q.querySelectorAll('input[type=radio]').forEach(r => r.checked = false);
    const fb = q.querySelector('.aq-feedback');
    fb.className = 'aq-feedback';
    fb.textContent = '';
  });
  document.getElementById('aq-result').style.display = 'none';
  document.getElementById('aq-error').style.display = 'none';
  const submitBtn = document.querySelector('#assessment-form button[onclick="submitAssessment()"]');
  if (submitBtn) submitBtn.style.display = '';
  document.getElementById('sec-assessment').scrollIntoView({behavior:'smooth'});
}

// ─── COMPLETION FORMS SUBMISSION (same pattern as games) ───
function submitCompletionAndGenerate() {
  const name  = document.getElementById('cert-name').value.trim();
  const house = document.getElementById('cert-house').value || '';
  const today = new Date();
  const dateStr = today.toLocaleDateString('en-AU', {day:'numeric', month:'long', year:'numeric'});

  const FORM_ID    = 'xccAZrUWr0uekzI72MAduqpmcw_jVYVCjN05AfEP1IdUNUg3SDdINVEzMEJURTZFNzJCSjZXQzZSMi4u';
  const FIELD_NAME = 'r9ee1232361704626b1eae66240bcb1f6';
  const FIELD_HSE  = 'ra1bf0215453547e2a32732afb66c0f0f';
  const FIELD_DATE = 'rf41dffc9b0d54db6852a3750e8285c43';

  const prefillUrl = 'https://forms.cloud.microsoft/Pages/ResponsePage.aspx?id=' + FORM_ID
    + '&' + FIELD_NAME + '=' + encodeURIComponent(name)
    + '&' + FIELD_HSE  + '=' + encodeURIComponent(house)
    + '&' + FIELD_DATE + '=' + encodeURIComponent(dateStr);

  window.open(prefillUrl, '_blank');
  generateCertificate();
}

// ─── CERTIFICATE GENERATION ───
function generateCertificate() {
  const name = document.getElementById('cert-name').value.trim();
  const house = document.getElementById('cert-house').value || '';
  const role = document.getElementById('cert-role').value.trim();
  const today = new Date();
  const dateStr = today.toLocaleDateString('en-AU', {day:'numeric', month:'long', year:'numeric'});



  const canvas = document.getElementById('cert-canvas');
  const ctx = canvas.getContext('2d');
  const W = canvas.width, H = canvas.height;

  // ── Colour palette ──────────────────────────────────────────
  const GREEN_DARK  = '#00180f';
  const GREEN_MID   = '#004d20';
  const GREEN_LIGHT = '#006b2c';
  const GOLD        = '#c9980a';
  const GOLD_LIGHT  = '#f2b400';
  const WHITE       = '#ffffff';
  const OFF_WHITE   = '#f7f7f7';

  // ── White background ────────────────────────────────────────
  ctx.fillStyle = WHITE;
  ctx.fillRect(0, 0, W, H);

  // ── Outer gold border (thick) ───────────────────────────────
  ctx.strokeStyle = GOLD_LIGHT;
  ctx.lineWidth = 10;
  ctx.strokeRect(14, 14, W - 28, H - 28);

  // ── Inner dark green border ─────────────────────────────────
  ctx.strokeStyle = GREEN_DARK;
  ctx.lineWidth = 3;
  ctx.strokeRect(28, 28, W - 56, H - 56);

  // ── Thin gold inner line ────────────────────────────────────
  ctx.strokeStyle = GOLD;
  ctx.lineWidth = 1;
  ctx.strokeRect(36, 36, W - 72, H - 72);

  // ── Dark green header band ──────────────────────────────────
  ctx.fillStyle = GREEN_DARK;
  ctx.fillRect(28, 28, W - 56, 90);

  // ── School name in header ───────────────────────────────────
  ctx.fillStyle = GOLD_LIGHT;
  ctx.font = 'bold 15px Georgia, serif';
  ctx.textAlign = 'center';
  ctx.letterSpacing = '3px';
  ctx.fillText('CORINDA STATE HIGH SCHOOL', W/2, 68);

  ctx.fillStyle = 'rgba(242,180,0,0.7)';
  ctx.font = '11px Georgia, serif';
  ctx.letterSpacing = '2px';
  ctx.fillText('POSITIVE EDUCATION PROGRAMME', W/2, 90);

  // ── Certificate of Completion label ─────────────────────────
  ctx.fillStyle = GREEN_MID;
  ctx.font = 'italic 15px Georgia, serif';
  ctx.letterSpacing = '1px';
  ctx.textAlign = 'center';
  ctx.fillText('Certificate of Completion', W/2, 148);

  // ── Thin gold rule below label ───────────────────────────────
  const ruleW = 300;
  ctx.strokeStyle = GOLD;
  ctx.lineWidth = 1;
  ctx.beginPath();
  ctx.moveTo(W/2 - ruleW/2, 158); ctx.lineTo(W/2 + ruleW/2, 158);
  ctx.stroke();

  // ── "This is to certify that" ────────────────────────────────
  ctx.fillStyle = '#444444';
  ctx.font = '13px Georgia, serif';
  ctx.letterSpacing = '0px';
  ctx.textAlign = 'center';
  ctx.fillText('This is to certify that', W/2, 190);

  // ── Recipient name ───────────────────────────────────────────
  ctx.fillStyle = GREEN_DARK;
  ctx.font = 'bold italic 52px Georgia, serif';
  ctx.textAlign = 'center';
  ctx.fillText(name, W/2, 258);

  // ── Name underline ───────────────────────────────────────────
  const nameWidth = Math.min(ctx.measureText(name).width + 80, W - 160);
  const lineX = (W - nameWidth) / 2;
  ctx.strokeStyle = GOLD;
  ctx.lineWidth = 2;
  ctx.beginPath();
  ctx.moveTo(lineX, 268); ctx.lineTo(lineX + nameWidth, 268);
  ctx.stroke();

  // ── Role ─────────────────────────────────────────────────────
  if (role) {
    ctx.fillStyle = GREEN_LIGHT;
    ctx.font = '15px Georgia, serif';
    ctx.textAlign = 'center';
    ctx.fillText(role, W/2, 298);
  }

  // ── "has successfully completed" ────────────────────────────
  const completedY = role ? 330 : 314;
  ctx.fillStyle = '#444444';
  ctx.font = '14px Georgia, serif';
  ctx.textAlign = 'center';
  ctx.fillText('has successfully completed', W/2, completedY);

  // ── Course title ─────────────────────────────────────────────
  const titleY = completedY + 44;
  ctx.fillStyle = GREEN_DARK;
  ctx.font = 'bold 26px Georgia, serif';
  ctx.textAlign = 'center';
  ctx.fillText('Positive Education & the PERMAH Framework', W/2, titleY);

  // ── Course subtitle ───────────────────────────────────────────
  ctx.fillStyle = '#666666';
  ctx.font = '13px Georgia, serif';
  ctx.fillText('A self-paced professional learning course for educators', W/2, titleY + 28);

  // ── Professional learning time ────────────────────────────────
  ctx.fillStyle = GREEN_DARK;
  ctx.font = 'bold 12px Georgia, serif';
  ctx.letterSpacing = '1px';
  ctx.textAlign = 'center';
  ctx.fillText('PROFESSIONAL LEARNING TIME: EQUIVALENT TO 60 MINUTES', W/2, titleY + 50);
  ctx.letterSpacing = '0px';

  // ── Gold divider ──────────────────────────────────────────────
  const divY = titleY + 66;
  ctx.strokeStyle = GOLD;
  ctx.lineWidth = 1.5;
  ctx.beginPath();
  ctx.moveTo(80, divY); ctx.lineTo(W - 80, divY);
  ctx.stroke();

  // ── PERMAH dots row ───────────────────────────────────────────
  const dotY = divY + 36;
  const dotColors = ['#2e7bb4','#c0392b','#7d3c98','#1e8449','#d68910','#0e6655'];
  const dotLabels = ['P','E','R','M','A','H'];
  const dotR = 18;
  const dotSpacing = 52;
  const dotStartX = W/2 - (dotColors.length - 1) * dotSpacing / 2;
  dotColors.forEach((c, i) => {
    const dx = dotStartX + i * dotSpacing;
    // filled circle
    ctx.beginPath();
    ctx.arc(dx, dotY, dotR, 0, Math.PI * 2);
    ctx.fillStyle = c;
    ctx.fill();
    // letter
    ctx.fillStyle = WHITE;
    ctx.font = 'bold 16px Georgia, serif';
    ctx.textAlign = 'center';
    ctx.fillText(dotLabels[i], dx, dotY + 6);
  });

  // ── APST section ──────────────────────────────────────────────
  const apstY = dotY + dotR + 24;

  // light green background band
  ctx.fillStyle = '#eaf5ee';
  ctx.fillRect(44, apstY - 8, W - 88, 74);
  ctx.strokeStyle = '#b8dfc4';
  ctx.lineWidth = 1;
  ctx.strokeRect(44, apstY - 8, W - 88, 74);

  ctx.fillStyle = GREEN_DARK;
  ctx.font = 'bold 11px Georgia, serif';
  ctx.letterSpacing = '1px';
  ctx.textAlign = 'center';
  ctx.fillText('AUSTRALIAN PROFESSIONAL STANDARDS FOR TEACHERS (APST) — Standards Addressed:', W/2, apstY + 10);

  // APST badges in a single row
  const apstStds = ['Std 1', 'Std 3', 'Std 4', 'Std 6', 'Std 7'];
  const apstLabels = ['Know Students', 'Plan & Implement', 'Safe Environments', 'Prof. Learning', 'Prof. Engagement'];
  const bW = 164, bH = 30, bGap = 6;
  const totalBW = apstStds.length * bW + (apstStds.length - 1) * bGap;
  const bStartX = (W - totalBW) / 2;
  const bY = apstY + 22;

  apstStds.forEach((s, i) => {
    const bx = bStartX + i * (bW + bGap);
    // badge fill
    ctx.fillStyle = GREEN_DARK;
    ctx.fillRect(bx, bY, bW, bH);
    // std label
    ctx.fillStyle = GOLD_LIGHT;
    ctx.font = 'bold 11px Georgia, serif';
    ctx.letterSpacing = '0px';
    ctx.textAlign = 'center';
    ctx.fillText(s, bx + bW/2, bY + 11);
    // description
    ctx.fillStyle = 'rgba(255,255,255,0.75)';
    ctx.font = '9px Georgia, serif';
    ctx.fillText(apstLabels[i], bx + bW/2, bY + 23);
  });

  // ── Bottom section ────────────────────────────────────────────
  const bottomY = H - 72;

  // thin rule above footer
  ctx.strokeStyle = '#cccccc';
  ctx.lineWidth = 1;
  ctx.beginPath();
  ctx.moveTo(80, bottomY - 24); ctx.lineTo(W - 80, bottomY - 24);
  ctx.stroke();

  // Date (left)
  ctx.fillStyle = '#888888';
  ctx.font = '10px Georgia, serif';
  ctx.letterSpacing = '1px';
  ctx.textAlign = 'left';
  ctx.fillText('DATE OF COMPLETION', 80, bottomY - 6);
  ctx.fillStyle = GREEN_DARK;
  ctx.font = 'bold 13px Georgia, serif';
  ctx.letterSpacing = '0px';
  ctx.fillText(dateStr, 80, bottomY + 12);

  // Authorised by (right)
  ctx.fillStyle = '#888888';
  ctx.font = '10px Georgia, serif';
  ctx.letterSpacing = '1px';
  ctx.textAlign = 'right';
  ctx.fillText('AUTHORISED BY', W - 80, bottomY - 6);
  ctx.fillStyle = GREEN_DARK;
  ctx.font = 'bold italic 13px Georgia, serif';
  ctx.letterSpacing = '0px';
  ctx.fillText('Head of Student Services', W - 80, bottomY + 12);

  // CSHS seal (centre)
  const sealX = W / 2, sealY = bottomY + 4;
  ctx.save();
  ctx.translate(sealX, sealY);
  // outer circle — gold
  ctx.beginPath(); ctx.arc(0, 0, 28, 0, Math.PI*2);
  ctx.fillStyle = GOLD_LIGHT;
  ctx.fill();
  // inner circle — dark green
  ctx.beginPath(); ctx.arc(0, 0, 22, 0, Math.PI*2);
  ctx.fillStyle = GREEN_DARK;
  ctx.fill();
  // text
  ctx.fillStyle = GOLD_LIGHT;
  ctx.font = 'bold 10px Georgia, serif';
  ctx.letterSpacing = '0px';
  ctx.textAlign = 'center';
  ctx.fillText('CSHS', 0, -3);
  ctx.fillText(new Date().getFullYear().toString(), 0, 9);
  ctx.restore();

  // Show modal
  document.getElementById('cert-modal').style.display = 'block';
  document.body.style.overflow = 'hidden';
}

function downloadCert() {
  const canvas = document.getElementById('cert-canvas');
  const name = document.getElementById('cert-name').value.trim().replace(/\s+/g,'_') || 'certificate';
  const link = document.createElement('a');
  link.download = `PERMAH_Certificate_${name}.png`;
  link.href = canvas.toDataURL('image/png');
  link.click();
}

function closeCert() {
  document.getElementById('cert-modal').style.display = 'none';
  document.body.style.overflow = '';
}
</script>
</body>
</html>
