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
  end

  def new
  end
end
