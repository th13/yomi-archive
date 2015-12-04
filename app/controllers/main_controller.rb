class MainController < ApplicationController
  # home page
  def home

  end

  # vocab page
  def vocab
    @vocab = [{ jp: '結婚', reading: 'けっこん', en: 'marriage', pos: 'noun (する-verb)' }]
    # vocab list
    #@words = User.first.words
  end

  # read page
  def read
    # if no seed, then random

    # random search - first get list of random seeds
    seeds = User.last.words.order("RANDOM()")
    jpn_sentence = Sentence.search(seeds[0], 3)

    puts jpn_sentence[:jpn] unless jpn_sentence.nil?
  end

  # analyze page
  def analyze
    if params[:search]
      @out = parse_sentence(params[:search])
    else
      @out = parse_sentence('これは何かです。')
    end
  end

  def new
  end


  private
    def parse_sentence(sentence)
      # TODO We probably should add a filter that gets the correct definition!!!
      words = Ve.in('ja').words(sentence)
      out = []
      words.each do |word|
        if word.part_of_speech != Ve::PartOfSpeech::Symbol
          search = URI(URI.encode('http://jisho.org/api/v1/search/words?keyword=' + word.lemma))
          res = JSON.parse(Net::HTTP.get(search))
          defin = res['data'][0]['senses'][0]['english_definitions'][0]
          out.push({ jp: word.word, def: defin, pos: word.part_of_speech.name })
        else
          out.push({ jp: word.word, def: '', pos: word.part_of_speech.name })
        end
      end

      return out
    end
end
