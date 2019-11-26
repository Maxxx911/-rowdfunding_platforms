class AddRoleToUser < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |t|
      t.string :role, default: 'user', null: false
    end
  end
end
