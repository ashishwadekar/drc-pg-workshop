class RestaurantBranch < ApplicationRecord
  belongs_to :restaurant
  has_many :branch_permissions, dependent: :destroy
  has_many :system_users, through: :branch_permissions
end
