class ChangeKeywords < ActiveRecord::Migration
  def change
    change_table :keywords do |t|
      t.remove :word_id
      t.string :word
    end
  end
end
