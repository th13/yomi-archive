class VocabController < ApplicationController
  def add
    if logged_in?
      working = false
      words = params[:words].split() || [param[:word]]
      newWords = Ve.in(:ja).words(words.join(''))
      newWords.each do |word|
        if !Vocab.find_by(word: word.lemma)
          @vocab = Vocab.new(user_id: current_user.id, word: word.lemma)
          if @vocab.save
            working = true
          else
            @error = 'Could not add word'
            working = false
            return
          end
        else
          puts 'DO FUCKING NOTHING !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
          redirect_to '/vocab'
          return
        end
      end

      if working
        redirect_to '/vocab'
      else
        @error = 'You aren\'t logged in how are you here?'
      end
    end
  end
end
