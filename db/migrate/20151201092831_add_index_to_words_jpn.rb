class AddIndexToWordsJpn < ActiveRecord::Migration
  def change
    add_index :words, :jpn, unique:true
  end
end
