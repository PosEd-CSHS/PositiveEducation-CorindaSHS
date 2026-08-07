// Corinda SHS Positive Education shared settings.
// Annual rollover: update the year and four term date ranges here only.
(function () {
  const terms = [
    { t: 1, start: '2026-01-27', end: '2026-04-02' },
    { t: 2, start: '2026-04-20', end: '2026-06-26' },
    { t: 3, start: '2026-07-13', end: '2026-09-18' },
    { t: 4, start: '2026-10-06', end: '2026-12-11' }
  ].map(Object.freeze);

  // The character strength or theme for each teaching week, in order, matching
  // the fortnightly lesson plans. Games display the current week's entry.
  const strengths = [
    // Term 1
    'Welcome back',
    'Positive Education intro',
    'PERMAH overview',
    'Virtues & character strengths',
    'Humanity',
    'Love',
    'Social Intelligence',
    'Kindness',
    'Transcendence',
    'Humour',
    // Term 2
    'Spirituality / Meaning',
    'Appreciation of Beauty',
    'Hope',
    'Gratitude',
    'Wisdom',
    'Love of Learning',
    'Perspective',
    'Curiosity',
    'Creativity',
    'Judgement',
    // Term 3
    'Virtues recap',
    'PERMAH recap',
    'Justice',
    'Leadership',
    'Fairness',
    'Teamwork',
    'Courage',
    'Zest',
    'Bravery',
    'Perseverance',
    // Term 4
    'Honesty',
    'Courage review',
    'Temperance',
    'Prudence',
    'Humility',
    'Self-Regulation',
    'Forgiveness',
    'Year in review',
    'Looking ahead',
    'Celebrate and reset',
  ].map(String);

  window.CSHS_SITE_CONFIG = Object.freeze({
    year: 2026,
    terms: Object.freeze(terms),
    strengths: Object.freeze(strengths),
    gamesHubUrl: 'https://qed05.instructure.com/courses/103375/pages/homegroup-games',
    programName: 'Corinda SHS Positive Education'
  });
})();
