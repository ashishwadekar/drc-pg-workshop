class AddUniquenessConstraintMenuItems < ActiveRecord::Migration[5.1]
  def up
    execute <<~SQL
      ALTER TABLE restaurant_branch_menu_items
          DROP CONSTRAINT IF EXISTS unique_item_in_restaurant
    SQL

    execute <<~SQL
      ALTER TABLE restaurant_branch_menu_items
        ADD CONSTRAINT unique_item_in_restaurant
        CHECK (NOT dup_menu_item_in_restaurant(menu_item_id, restaurant_branch_id));
    SQL
  end

  def down
    execute <<~SQL
      ALTER TABLE restaurant_branch_menu_items
          DROP CONSTRAINT IF EXISTS unique_item_in_restaurant
    SQL
  end
end
