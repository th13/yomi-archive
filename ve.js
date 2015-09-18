var http = require('http')
http.post = require('http-post')

module.exports = {
	words: function(text, callback) {
		http.post('http://localhost:4567/ja/words', { text: text }, function(res) {
			res.setEncoding('utf8')
			var body = ''
			res.on('data', function(data) {
				body += data
			})
			res.on('end', function() {
				return callback(body)
			})
		})
	}
}
