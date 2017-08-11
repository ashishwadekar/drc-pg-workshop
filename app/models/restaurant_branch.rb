class RestaurantBranch < ApplicationRecord
  belongs_to :restaurant
  has_many :branch_permissions, dependent: :destroy
  has_many :system_users, through: :branch_permissions
  has_many :restaurant_branch_menu_items
  has_many :menu_items, through: :restaurant_branch_menu_items # Query 1
  has_many :siblings, through: :restaurant, source: :branches, class_name: "RestaurantBranch"

  def address=(components)
    write_attribute(:address, Types::Address.new(*components).to_db)
  end

  def address
    Types::Address.from_db(read_attribute(:address))
  end

  def restaurant_menu_items
    restaurant.menu_items # query 3
  end

  def menu
    # query 4
    # union = restaurant_menu_items.union(menu_items)
    # m = MenuItem.arel_table
    # q = m.create_table_alias(union, :menu_items)
    # MenuItem.from(q, :menu_items).all

    MenuItem.find_by_sql <<~SQL
      #{restaurant_menu_items.to_sql} UNION #{menu_items.to_sql}
    SQL
  end

  def add_menu_item(attributes)
    transaction do
      menu_item = MenuItem.create!(attributes)
      self.menu_items << menu_item
    end
  end
end
