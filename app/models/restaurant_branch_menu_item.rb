class RestaurantBranchMenuItem < ApplicationRecord
  belongs_to :restaurant_branch
  belongs_to :menu_item
end
