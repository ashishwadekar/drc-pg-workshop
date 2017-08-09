FactoryGirl.define do
  factory :wizard do
    name { Faker::Name.unique.name }
    description { Faker::HarryPotter.quote }
  end
end
