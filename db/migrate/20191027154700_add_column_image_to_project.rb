class AddColumnImageToProject < ActiveRecord::Migration[5.2]
  def change
    change_table :projects do |t|
      t.string :image_url
    end
  end
end
