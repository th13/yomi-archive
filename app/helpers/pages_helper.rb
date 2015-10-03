module PagesHelper
  def partOfSpeechClass(pos)
    pos.sub! ' ', '-'
    pos
  end
end
