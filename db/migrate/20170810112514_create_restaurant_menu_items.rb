class CreateRestaurantMenuItems < ActiveRecord::Migration[5.1]
  def change
    create_table :restaurant_menu_items do |t|
      t.integer :restaurant_id
      t.integer :menu_item_id
    end

    add_foreign_key :restaurant_menu_items, :restaurants, on_delete: :cascade
    add_foreign_key :restaurant_menu_items, :menu_items, on_delete: :cascade
  end
end
