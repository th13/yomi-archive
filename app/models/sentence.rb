class Sentence < ActiveRecord::Base
  belongs_to :user
  has_many :keywords
  has_many :words, :through => :keywords

  validates :user_id, presence: true

  # this is the key search function
  # it takes in a seed and then uses it to find a sentence
  # it also allows a user to specify how many new words can be included
  def Sentence.search(seed, new_words_allowed)
    # change 2 to user id
    # get random sentence using seed word from user sentences
    sentences = seed.sentences.where(user_id: 1 || 2).order("RANDOM()")
    # calculate amount of new words  -- change 2 to current user
    sentences.each do |sentence|
      new_words =  sentence.words.count - sentence.words.joins(:users).where("user_id = 2").count
      if (new_words <= new_words_allowed)
        return sentence
      end
    end
    # if nothing found
    return nil
  end
end
