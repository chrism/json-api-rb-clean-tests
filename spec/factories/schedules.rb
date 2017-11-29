FactoryBot.define do
  factory :schedule do
    name { Faker::Lorem.sentence }
    current_position { Faker::Number.between(1, 10) }
  end
end
