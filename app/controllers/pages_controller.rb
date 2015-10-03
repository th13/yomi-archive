class PagesController < ApplicationController
  def home
  end

  def article
    @article = Article.find(params[:id])
    @words = words(@article.text)
  end

  private
    def words(text)
      @words = Ve.in(:ja).words(text)
    end
end
