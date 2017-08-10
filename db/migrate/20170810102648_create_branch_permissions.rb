class CreateBranchPermissions < ActiveRecord::Migration[5.1]
  def change
    create_table :branch_permissions do |t|
      t.integer :system_user_id, null: false
      t.integer :restaurant_branch_id, null: false
    end

    add_foreign_key :branch_permissions, :system_users, on_delete: :cascade
    add_foreign_key :branch_permissions, :restaurant_branches, on_delete: :cascade
  end
end
