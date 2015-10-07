

class Article < ActiveRecord::Base
  validates :text, presence: true
end
