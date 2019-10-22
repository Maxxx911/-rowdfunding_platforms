class EditUserModel < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |t|
      t.remove :name
      t.string :firs_name, null: false, default: ''
      t.string :middle_name, null: false, default: ''
      t.string :last_name, null: false, default: ''
      t.string :login, null: false, default: ''
      t.datetime :birthday, null: false
    end
  end
end
