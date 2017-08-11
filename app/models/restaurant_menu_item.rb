class RestaurantMenuItem < ApplicationRecord
  belongs_to :restaurant
  belongs_to :menu_item
end
