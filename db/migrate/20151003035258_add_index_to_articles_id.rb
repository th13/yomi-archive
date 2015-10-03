class AddIndexToArticlesId < ActiveRecord::Migration
  def change
    add_index :articles, :id, unique: true
  end
end
