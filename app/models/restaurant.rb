class Restaurant < ApplicationRecord
  has_many :branches, class_name: "RestaurantBranch"
  has_many :system_users
  has_many :restaurant_menu_items
  has_many :menu_items, through: :restaurant_menu_items

  def branch_menu_items
    branches.menu_items
  end
end
