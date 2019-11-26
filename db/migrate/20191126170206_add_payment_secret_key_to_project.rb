class AddPaymentSecretKeyToProject < ActiveRecord::Migration[5.2]
  def change
    change_table :projects do |t|
      t.string :payment_secret
    end
  end
end
