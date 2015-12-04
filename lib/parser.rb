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
   word_obj = Word.find_by(jpn: word)
   if (word_obj.nil?)
     # get jisho search
     search = URI(URI.encode('http://jisho.org/api/v1/search/words?keyword=' + word))
     result = JSON.parse(Net::HTTP.get(search))
     word_obj = Word.create!(jpn: word,
  	  reading: result['data'][0]['japanese'][0]['reading'],
  	  eng: result['data'][0]['senses'][0]['english_definitions'][0],
      pos: result['data'][0]['senses'][0]['parts_of_speech'][0])
   end 
   Keyword.create!(sentence_id: jpn_sentence[:id], word_id: word_obj[:id])
 end

 return jpn_words
end

end
