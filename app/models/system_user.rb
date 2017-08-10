class SystemUser < ApplicationRecord
  belongs_to :restaurant
  has_many :branch_permissions, dependent: :destroy
  has_many :restaurant_branches, through: :branch_permissions
end
