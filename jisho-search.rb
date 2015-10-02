require 'net/http'
require 'json'
require 've'
require "mojinizer"

def
words = Ve.in(:ja).words('田中先生がどこに住んでいるか知っていますか。')

words.collect! do |word|
	if word.part_of_speech != Ve::PartOfSpeech::Symbol
		word.lemma
	else
		''
	end
end
words.reject!(&:empty?)

words.each do |word|
	search = URI(URI.encode('http://jisho.org/api/v1/search/words?keyword=' + word))
	result = JSON.parse(Net::HTTP.get(search))
	puts result['data'][0]['japanese']
	puts result['data'][0]['senses'][0]['english_definitions']
end
