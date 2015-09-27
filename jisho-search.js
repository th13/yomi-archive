/*
* jisho-search.js
*
* Uses Ve to tokenize Japanese (can be a work, phrase, sentence, paragraph) and
* searches jisho.org.
*
* TODO: Deattach する (and derivations of e.g. している) from suru-verbs.
* TODO: Determine how to pass definitions to the to-be-created front end system.
* TODO: Figure out how to define postpositions
* TODO: Modularize this to work in the webapp
*/

var _ = require('lodash')
var http = require('http')
var jpc = require('jp-conversion')
var Ve = require('./ve')

Ve.words('チーズ', function(words) {
	words = JSON.parse(words)

	var romaji = []
	_(words).forEach(function(word) {
		// See docs for jishoQuery on why we convert to romaji
		var parsed = jpc.romanise(word.extra.reading).toLowerCase()

		// Jisho.org doesn't define symbols or particles (aka postpositions)
		if (word.part_of_speech != 'symbol' && word.part_of_speech != 'postposition') {
			//console.log(parsed)
			romaji.push(parsed)
		}
	}).value()

	for(var i = 0; i < romaji.length; i++) {
		jishoQuery(romaji[i], function(data) {
			// data[0] contains on the first search result from jisho. This is
			// likely good enough (especially for common words), but could render
			// definitions incomplete
			// TODO: Determine if we should add more definitions or alternatively
			// link to the jisho.org page for the selected word
			if (data[0] != undefined) {
				console.log(data[0].japanese)		// Kanji (if applicable) and readings
				console.log(data[0].senses[0].english_definitions + '\n')
			}
		})
	}
})

// Could not for the life of me figure out how to use Japanese kana or kanji in
// this get request. For some reason Node kills it (i.e. uses a different encoding
// than UTF8???). Hence why in the above code we convert to romaji first. This
// doesn't seem to affect the results too heavily, though.
var jishoQuery = function (word, callback) {
	http.get('http://jisho.org/api/v1/search/words?keyword=' + word, function(res) {
		body = ''
		res.on('data', function(data) {
			body += data
		})
		res.on('end', function() {
			body = JSON.parse(body)
			callback(body.data)
		})
	})
}
