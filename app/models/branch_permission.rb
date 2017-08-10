class BranchPermission < ApplicationRecord
  belongs_to :system_user
  belongs_to :restaurant_branch
end
