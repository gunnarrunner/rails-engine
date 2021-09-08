FactoryBot.define do
  factory :item do
    name { Faker::Games::Pokemon.name }
    description { Faker::Lorem.sentence }
    unit_price { rand(10.0..100.0).round(2) }
    merchant
  end
end