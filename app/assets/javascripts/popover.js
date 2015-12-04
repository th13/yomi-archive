'use strict';

$(".main.analyze").ready(function() {
  // This handy trick makes the links essentially not links.
  var def;

  $('a.jp').click(function(e) {
    e.preventDefault();
  });

  $('[data-toggle="popover"]').popover();
});
