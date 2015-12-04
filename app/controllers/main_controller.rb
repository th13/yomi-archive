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


  # analyze page
  def read
    vocablist = []
    current_user.vocabs.each do |vocab|
      vocablist.push(vocab[:word])
    end

    seed = ''
    if params[:search]
      seed = params[:search]
    else
      seed = vocablist.sample
    end

    sentence = Sentence.search(seed, vocablist, current_user.max_unknown || 5)
    while sentence == nil
      puts "WTF IS HAPPENING"
      sentence = Sentence.search(vocablist.sample, vocablist, params[:limit] || 5)
    end
    @seed = seed
    @out = parse_sentence(sentence[:jpn])
    @eng = sentence[:eng]
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
