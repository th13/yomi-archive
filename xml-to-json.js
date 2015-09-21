var parser = require('xml2json');
var fs = require('fs');

var xml = fs.readFileSync('/Users/trevor1/Downloads/JMdict_e.xml', { encoding: 'utf8' });
var json = parser.toJson(xml);

fs.writeFile('JMdict_e.json', json, function(err) {
	if (err) throw err
	console.log('JMdict_e.json created!')
})
