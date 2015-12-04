class ChangeVocabToStoreWord < ActiveRecord::Migration
  def change
    change_table :vocabs do |t|
      t.remove :word_id
      t.string :word
    end
  end
end
