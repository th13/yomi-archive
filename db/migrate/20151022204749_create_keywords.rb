class CreateKeywords < ActiveRecord::Migration
  def change
    create_table :keywords do |t|
      t.string :word
      t.references :sentence, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
