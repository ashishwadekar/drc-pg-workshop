FactoryGirl.define do
  factory :restaurant_branch, aliases: [:branch] do
    restaurant
    name { Faker::Address.community }
    address { [Faker::Address.city, Faker::Address.street_name] }
  end
end
