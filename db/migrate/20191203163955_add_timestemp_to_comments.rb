class AddTimestempToComments < ActiveRecord::Migration[5.2]
  def change
    change_table :comments do |t|
      t.datetime :created_at
    end
  end
end
