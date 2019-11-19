class CreatePaymentMethods < ActiveRecord::Migration[5.2]
  def change
    create_table :payment_methods do |t|
      t.string :client_id, null: false
      t.string :client_secret, null: false
      t.string :title, null: false, default: ''
      t.belongs_to :project
    end
  end
end
