class AddRestaurantNameUniqueness < ActiveRecord::Migration[5.1]
  def up
    execute <<~SQL
      CREATE UNIQUE INDEX restaurant_name_uniqueness ON restaurants (LOWER(name))
    SQL
  end

  def down
    execute <<~SQL
      DROP INDEX restaurant_name_uniqueness
    SQL
  end
end
