require 'net/http'
require 'json'
require 've'
require "mojinizer"

module Parser

# use ve to parse sentence, uses jisho to get definition
# stores words in database and makes connections
# returns words parsed
def Parser.parse_sentence(jpn_sentence)

  # run through ve
  jpn_words = Ve.in(:ja).words(jpn_sentence[:jpn])

  # return just lemma words and eliminate symbols
  jpn_words.collect! do |word|
  	if ((word.part_of_speech != Ve::PartOfSpeech::Symbol) &&
       (word.part_of_speech != Ve::PartOfSpeech::Postposition) &&
       (word.part_of_speech != Ve::PartOfSpeech::Number))
  		word.lemma
  	else
  		''
  	end
  end

  # delete if empty
 jpn_words.reject!{|word| word.empty? || word == '*'}

 # save words to Word database if not in there already, then make association
 jpn_words.each do |word|
  # get jisho search
  # search = URI(URI.encode('http://jisho.org/api/v1/search/words?keyword=' + word))
  # result = JSON.parse(Net::HTTP.get(search))
  Keyword.create!(sentence_id: jpn_sentence[:id], word: word)
 end

 return jpn_words
end

end
