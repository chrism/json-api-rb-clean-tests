FactoryBot.define do
  factory :scheduled_track do
    position { Faker::Number.between(1, 10) }
    state "queued"
  end
end
