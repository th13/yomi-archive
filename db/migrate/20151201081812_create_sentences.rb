class CreateSentences < ActiveRecord::Migration
  def change
    create_table :sentences do |t|
      t.text :jpn
      t.text :eng
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
