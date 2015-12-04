class MainController < ApplicationController
  def home

  end

  # search bar
  def search

  end

  def vocab
    # vocab list
    @words = User.first.words
  end

  def read
    # if no seed, then random

    # random search - first get list of random seeds
    seeds = User.last.words.order("RANDOM()")
    jpn_sentence = Sentence.search(seeds[0], 3)

    puts jpn_sentence[:jpn] unless jpn_sentence.nil?
  end

  def analyze
  end
end
