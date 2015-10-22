class SentencesController < ApplicationController
  def index
  end

  def show
    sentence = Sentence.find(params[:id])
    @words = Ve.in(:ja).words(sentence.text)
  end
end
