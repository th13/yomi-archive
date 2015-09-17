// Test the Ve server with some Node!
var http = require('http')
http.post = require('http-post')

var url = 'localhost:4567'		// Ve server runs on 4567 (maybe change that in production?)
var language = 'ja'				// Don't think we'll need English parsing?

var data = []

var text = 'こんにちは！元気ですか。私はトレバー・ヘルムズと言います。日本語とコンピュータを勉強している学生です。'

var data = {
	text: text
}

http.post('http://localhost:4567/ja/words', data, function(res) {
	res.setEncoding('utf8')
	var body = ''
	res.on('data', function(data) {
		body += data
	})
	res.on('end', function() {
		console.log(body)
	})
})
