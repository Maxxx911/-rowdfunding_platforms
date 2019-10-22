class ChangeColumnFirsNameToFirstName < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |t|
      t.rename :firs_name, :first_name
    end
  end
end
