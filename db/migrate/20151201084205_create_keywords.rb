class CreateKeywords < ActiveRecord::Migration
  def change
    create_table :keywords do |t|
      t.references :sentence, index: true, foreign_key: true
      t.references :word, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
