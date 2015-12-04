class VocabController < ApplicationController
  def add
    if logged_in?
      working = false
      words = params[:words].split() || [param[:word]]
      newWords = Ve.in(:ja).words(words.join(''))
      newWords.each do |word|
        @vocab = Vocab.new(user_id: current_user.id, word: word.lemma)
        if @vocab.save
          working = true
        else
          @error = 'Could not add word'
          working = false
          return
        end
      end

      if working
        redirect_to '/vocab'
      end
    else
      @error = 'You aren\'t logged in how are you here?'
    end
  end
end
