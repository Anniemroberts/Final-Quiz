FactoryGirl.define do
  factory :bid do
    bid { Faker::Number.between(1, 1000)}
  end
end
