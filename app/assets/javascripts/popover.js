'use strict';

$(".main.analyze").ready(function() {
  // This handy trick makes the links essentially not links.
  var def;

  $('a.jp').click(function(e) {
    e.preventDefault();
    var word = $(this).text().trim();
    console.log($(this).text());
    $('#vocabToAdd').append(word + '&nbsp;&nbsp;&nbsp;');
    var old = $('#vocabForm').val();
    $('#vocabForm').val(old + word + '\n');
  });

  $('#clearVocab').click(function() {
    $('#vocabToAdd').text(' ');
    $('#vocabForm').val(' ');
  });

  $('[data-toggle="popover"]').popover();


});
