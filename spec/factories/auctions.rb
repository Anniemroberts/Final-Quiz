FactoryGirl.define do
  factory :auction do
    title { Faker::Lorem.word}
    details { Faker::Lorem.sentence }
    current_price { 0 }
    ends_on{ Faker::Date.forward(23)}
    reserve_price { Faker::Number.decimal(2)}
  end
end
