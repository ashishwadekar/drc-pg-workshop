class RestaurantBranch < ApplicationRecord
  belongs_to :restaurant
  has_many :branch_permissions, dependent: :destroy
  has_many :system_users, through: :branch_permissions
  has_many :restaurant_branch_menu_items
  has_many :menu_items, through: :restaurant_branch_menu_items # Query 1

  def address=(components)
    write_attribute(:address, Types::Address.new(*components).to_db)
  end

  def address
    Types::Address.from_db(read_attribute(:address))
  end

  def restaurant_menu_items
    restaurant.menu_items
  end
end
