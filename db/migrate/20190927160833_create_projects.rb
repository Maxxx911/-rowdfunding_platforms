class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :title, null: false, default: ''
      t.text :description, null: false, default: ''
      t.datetime :end_time
      t.float :sum_goal, null: false, default: 1.0
      t.float :current_sum, null: false, default: 0
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
