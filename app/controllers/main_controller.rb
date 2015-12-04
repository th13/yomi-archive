class MainController < ApplicationController
  # home page
  def home
  end

  # vocab page
  def vocab
    #@vocab = [{ jp: '結婚', reading: 'けっこん', en: 'marriage', pos: 'noun (する-verb)' }]
    # vocab list
    if current_user
      @test = []
      @words = Vocab.where(user_id: current_user.id)
      @words.each do |word|
        if !word[:def]
          jp = Ve.in('ja').words(word[:word])[0]
          if jp.part_of_speech != Ve::PartOfSpeech::Symbol
            search = URI(URI.encode('http://jisho.org/api/v1/search/words?keyword=' + jp.lemma))
            res = JSON.parse(Net::HTTP.get(search))
            defin = res['data'][0]['senses'][0]['english_definitions'][0]
            @test.push({ jp: jp.word, def: defin, pos: jp.part_of_speech.name, reading: jp.extra[:reading] })
            word.def = defin
            word.save
          else
            @test.push({ jp: jp.word, def: '', pos: jp.part_of_speech.name, reading: '' })
          end
        else
          jp = Ve.in('ja').words(word[:word])[0]
          @test.push({ jp: jp.word, def: word[:def], pos: jp.part_of_speech.name, reading: jp.extra[:reading] })
        end
      end
      @words = @test
      puts @words
    else
      @words = [{ jp: '結婚', reading: 'けっこん', en: 'marriage', pos: 'noun (する-verb)' }]
    end
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
          out.push({ jp: word.word, def: defin, pos: word.part_of_speech.name, reading: word.extra[:reading] })
        else
          out.push({ jp: word.word, def: '', pos: word.part_of_speech.name, reading: '' })
        end
      end

      return out
    end
end
