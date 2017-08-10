class CreateSystemUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :system_users do |t|
      t.belongs_to :restaurant, foreign_key: true
      t.string :username
      t.string :password
    end
  end
end
