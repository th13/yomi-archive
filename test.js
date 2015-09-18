var Ve = require('./ve')
var _ = require('lodash')

Ve.words('こんにちは！元気ですか。私はトレバー・ヘルムズと言います。日本語とコンピュータを勉強している学生です。', function(words) {
	words = JSON.parse(words)
	text = ''
	_(words).forEach(function(word) {
		text += word.word
	}).value()

	console.log(text)
})
