class CreateRestaurantBranches < ActiveRecord::Migration[5.1]
  def change
    reversible do |dir|
      dir.up do
        execute <<-SQL
          CREATE TYPE full_address AS
          (
            city VARCHAR(90),
            street VARCHAR(90)
          );
        SQL
      end

      dir.down do
        execute "DROP TYPE IF EXISTS full_address"
      end
    end

    create_table :restaurant_branches do |t|
      t.belongs_to :restaurant, foreign_key: true
      t.string :name
      t.column :address, :full_address
    end
  end
end
