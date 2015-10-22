class RenameArticlesToSentences < ActiveRecord::Migration
  def change
    rename_table :articles, :sentences
  end
end
