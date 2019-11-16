class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :text, null: false, default: ''
      t.belongs_to :project, index: true
      t.belongs_to :user, index: true
    end
  end
end
