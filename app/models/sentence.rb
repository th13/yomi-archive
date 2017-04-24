class Sentence < ActiveRecord::Base
  has_many :keywords

  # this is the key search function
  # it takes in a seed and then uses it to find a sentence
  # it also allows a user to specify how many new words can be included
  def Sentence.search(seed, vocab, new_words_allowed)
    keywords = Keyword.where(word: seed)
    sentences = []
    keywords.each do |keyword|
      sentences.push(keyword.sentence)
    end

    puts sentences.count
    sentences.each do |sentence|
      c = 0
      raw = []
      sentence.keywords.each { |kw| raw.push(kw[:jpn]) }
      raw.each do |word|
        if !vocab.include?(word)
          c += 1
        end
      end
      if c <= new_words_allowed
        puts c
      else
        puts 'Sentence not a match'
      end
      if c > new_words_allowed
        sentences = sentences - [sentence]
      end
    end

    sentences.sample
  end
end
