class User < ActiveRecord::Base
  has_many :sentences, dependent: :destroy
  has_many :vocabs, dependent: :destroy
  has_many :words, :through => :vocabs
end
