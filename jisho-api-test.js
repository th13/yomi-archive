var http = require('http')

http.get('http://jisho.org/api/v1/search/words?keyword=ie', function(res) {
	body = ''
	res.on('data', function(data) {
		body += data
	})
	res.on('end', function() {
		console.log(body)
	})
})
