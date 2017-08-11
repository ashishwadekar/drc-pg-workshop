# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def create_branch(restaurant, system_user)
  branch = restaurant.branches.create!(
    name: Faker::Address.community,
    address: [Faker::Address.city, Faker::Address.street_name]
  )

  system_user.restaurant_branches << branch

  number_of_branch_menu_items = rand(0..6) # between 0 and 5

  number_of_branch_menu_items.times do
    branch.menu_items.create!(
      name: Faker::Food.dish,
      description: Faker::Hipster.paragraph(2, false),
      price: Faker::Commerce.price,
    )
  end
end

def create_restaurant
  restaurant = Restaurant.create!(
    name: "#{Faker::App.name} #{Faker::App.name}",
    description: Faker::Hipster.paragraph(2, false)
  )

  system_user = restaurant.system_users.create!(
    username: Faker::Internet.user_name,
    password: SecureRandom.hex(10),
  )

  number_of_menu_items = rand(0..6) # between 0 and 5

  number_of_menu_items.times do
    restaurant.menu_items.create!(
      name: Faker::Food.dish,
      description: Faker::Hipster.paragraph(2, false),
      price: Faker::Commerce.price,
    )
  end

  number_of_branches = rand(0..6) # between 0 and 5

  number_of_branches.times do
    create_branch(restaurant, system_user)
  end
end


1000.times do
  create_restaurant rescue next
end
