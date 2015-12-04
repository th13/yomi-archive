'use strict';

$(".main.analyze").ready(function() {
  // This handy trick makes the links essentially not links.
  var def;

  $('a.jp').click(function(e) {
    e.preventDefault();
  });

  $('[data-toggle="popover"]').popover();

  $('.add-vocab').click(function(e) {
    var word = $(this).attr('data-word');
    console.log('testing');

    $.ajax({
        type: 'post',
        url: '/vocab/add',
        data: {
          word: word
        },
        contentType: 'application/json',
        success: function(res) {
          console.log('success')
        },
        error: function() {
          return console.log('error l2');
        }
      });
  });
});
