// Corinda SHS Positive Education shared settings.
// Annual rollover: update the year and four term date ranges here only.
(function () {
  const terms = [
    { t: 1, start: '2026-01-27', end: '2026-04-02' },
    { t: 2, start: '2026-04-20', end: '2026-06-26' },
    { t: 3, start: '2026-07-13', end: '2026-09-18' },
    { t: 4, start: '2026-10-06', end: '2026-12-11' }
  ].map(Object.freeze);

  window.CSHS_SITE_CONFIG = Object.freeze({
    year: 2026,
    terms: Object.freeze(terms),
    gamesHubUrl: 'https://qed05.instructure.com/courses/103375/pages/homegroup-games',
    programName: 'Corinda SHS Positive Education'
  });
})();
