var Ve = require('./ve')
var _ = require('lodash')
var jpc = require('jp-conversion')
var http = require('http')

Ve.words('昨日すき焼きを食べました', function(words) {
	words = JSON.parse(words)

	var romaji = []
	_(words).forEach(function(word) {
		var parsed = jpc.romanise(word.extra.reading).toLowerCase()

		if (word.part_of_speech != 'symbol' && word.part_of_speech != 'postposition') {
			console.log(parsed)
			romaji.push(parsed)
		}
	}).value()

	for(var i = 0; i < romaji.length; i++) {
		jishoQuery(romaji[i], function(data) {
			if (data[0] != undefined) {
				console.log(data[0].japanese)
				console.log(data[0].senses[0].english_definitions + '\n')
			}
		})
	}
})

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
