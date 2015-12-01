class Sentence < ActiveRecord::Base
  belongs_to :user
  has_many :keywords
  has_many :words, :through => :keywords
  
  validates :user_id, presence: true
end
