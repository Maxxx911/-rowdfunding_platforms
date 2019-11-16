class CreateCategoriesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :name, null: false
    end
    add_index :categories, :name
  end
end
