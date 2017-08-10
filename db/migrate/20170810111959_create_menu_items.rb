class CreateMenuItems < ActiveRecord::Migration[5.1]
  def change
    create_table :menu_items do |t|
      t.string :name
      t.string :description
      t.decimal :price, scale: 2, precision: 10
    end
  end
end
