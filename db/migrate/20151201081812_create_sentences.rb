class CreateSentences < ActiveRecord::Migration
  def change
    create_table :sentences do |t|
      t.txt :jpn
      t.txt :eng
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
