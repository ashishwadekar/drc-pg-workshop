class CreateRestaurantBranchMenuItems < ActiveRecord::Migration[5.1]
  def change
    create_table :restaurant_branch_menu_items do |t|
      t.integer :restaurant_branch_id
      t.integer :menu_item_id
      t.belongs_to :system_user, foreign_key: true
    end

    add_foreign_key :restaurant_branch_menu_items, :restaurant_branches, on_delete: :cascade
    add_foreign_key :restaurant_branch_menu_items, :menu_items, on_delete: :cascade
  end
end
