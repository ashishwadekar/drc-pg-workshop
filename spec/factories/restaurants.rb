FactoryGirl.define do
  factory :restaurant do
    name { "#{Faker::App.name} #{Faker::App.name} #{SecureRandom.hex(2)}" }
    description { Faker::Hipster.paragraph(2, false) }
  end
end
