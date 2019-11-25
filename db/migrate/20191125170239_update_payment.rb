class UpdatePayment < ActiveRecord::Migration[5.2]
  def change
    change_table :payments do |t|
      t.bigint :amount, default: 0, null: false
    end
  end
end
