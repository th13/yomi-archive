class Sentence < ActiveRecord::Base
  has_many :keywords
  validates :text, presence: true
end
