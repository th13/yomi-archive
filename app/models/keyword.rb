class Keyword < ActiveRecord::Base
  belongs_to :sentence
  belongs_to :word
end
