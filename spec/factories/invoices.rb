FactoryBot.define do
  factory :invoice do
    status { ['shipped', 'returned', 'packaged'].sample }
    customer
    merchant
  end
end