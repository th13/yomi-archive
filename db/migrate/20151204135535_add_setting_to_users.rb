class AddSettingToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.integer :max_unknown
    end
  end
end
