class AddDefToVocab < ActiveRecord::Migration
  def change
    change_table :vocabs do |t|
      t.string :def
    end
  end
end
