class AddDetailsToWords < ActiveRecord::Migration
  def change
    add_column :words, :reading, :string
    add_column :words, :eng, :string
    add_column :words, :pos, :string
  end
end
