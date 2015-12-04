class MainController < ApplicationController
  def home
    render 'home'
  end

  def vocab
    @vocab = [{ jp: '結婚', reading: 'けっこん', en: 'marriage', pos: 'noun (する-verb)' }]
  end

  def read
  end

  def analyze
    # TODO We probably should add a filter that gets the correct definition!!!
    @words = Ve.in('ja').words('これは本当に何もじゃないです。')
    @out = []
    @words.each do |word|
      if word.part_of_speech != Ve::PartOfSpeech::Symbol
        search = URI(URI.encode('http://jisho.org/api/v1/search/words?keyword=' + word.lemma))
        res = JSON.parse(Net::HTTP.get(search))
        defin = res['data'][0]['senses'][0]['english_definitions'][0]
        @out.push({ jp: word.word, def: defin, pos: word.part_of_speech.name })
      else
        @out.push({ jp: word.word, def: '', pos: word.part_of_speech.name })
      end
    end

    puts @out
  end

  def new
  end
end
