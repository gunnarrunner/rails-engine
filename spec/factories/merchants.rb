FactoryBot.define do
  factory :merchant do
    name { Faker::Games::Fallout.character}
  end
end