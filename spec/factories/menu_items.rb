FactoryGirl.define do
  factory :menu_item do
    name { "#{Faker::Food.dish} #{SecureRandom.hex(2)}" }
    description { Faker::Hipster.paragraph(2, false) }
    price Faker::Commerce.price
  end
end
