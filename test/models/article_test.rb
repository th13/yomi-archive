require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @article = Article.new(text: '田中先生がどこに住んでいるか知っていますか。')
  end

  test "should be valid" do
    assert @article.valid?
  end

  test "text should exist" do
    @article.text = ""
    assert_not @article.valid?
  end
end
