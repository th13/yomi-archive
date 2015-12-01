class Word < ActiveRecord::Base
  has_many :keywords
  has_many :sentences, :through => :keywords
  has_many :vocabs
  has_many :users, :through => :vocabs
end
