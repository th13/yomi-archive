var http = require('http')
var querystring = require('querystring')

http.get('http://jisho.org/api/v1/search/words?keyword=kyoumi', function(res) {
	body = ''
	res.on('data', function(data) {
		body += data
	})
	res.on('end', function() {
		body = JSON.parse(body)
		console.log(body.data[0].japanese)
		console.log('\n' + body.data[0].senses[0].english_definitions)
	})
})
