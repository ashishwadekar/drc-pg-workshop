class MenuItem < ApplicationRecord
  has_many :restaurant_menu_items
  has_many :restaurants, through: :restaurant_menu_items
  has_many :restaurant_branch_menu_items
  has_many :restaurant_branches, through: :restaurant_branch_menu_items

  scope :by_branches_of_a_restaurant, ->(restaurant) {
    # query 2

    joins(:restaurant_branches)
      .merge(restaurant.branches)
      .distinct
  }

  scope :restaurant_menu_items_for_branch, ->(branch) {

  }
end
