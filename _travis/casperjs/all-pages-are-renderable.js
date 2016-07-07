/*globals casper:false */
[
  '/about-me.html',
  '/unsubscribe.html',
  '/rss',
  '/rss.xml',
  '/sitemap.xml',
  '/index.html',
  '/css/layout.css',
  '/css/icons.css',
  '/robots.txt',
  '/js/global.js'
].forEach(
  function (page) {
    casper.test.begin(
      page + ' page can be rendered',
      function (test) {
        casper.start('http://localhost:4000' + page, function () {
            test.assertHttpStatus(200);
        });
        casper.run(function () {
          test.done();
        });
      }
    );
  }
);
