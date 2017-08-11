FactoryGirl.define do
  factory :system_user do
    restaurant
    username { Faker::Internet.user_name }
    password { SecureRandom.hex(10) }
  end
end
