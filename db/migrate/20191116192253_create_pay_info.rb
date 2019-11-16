class CreatePayInfo < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.string :title, null: false
      t.string :desctiption, null: false
      t.string :passport_number, null: false
      t.string :address, null: false
      t.datetime :birthday, null: false
      t.string :payment_method, null: false
      t.belongs_to :project, index: true
      t.belongs_to :user, index: true
    end
  end
end
