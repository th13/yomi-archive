class MainController < ApplicationController
  # home page
  def home

  end

  # vocab page
  def vocab
    # vocab list
    @words = User.first.words
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
  end

  # search bar post route  # search bar
  def search

  end
end
