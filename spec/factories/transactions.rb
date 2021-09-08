FactoryBot.define do
  factory :transaction do
    credit_card_number { Faker::Number.number(digits: 16) }
    credit_card_expiration_date { Faker::Date.between(from: Date.today, to: Date.today + 90) }
    result { ['failed', 'refunded', 'success'].sample }
    invoice
  end
end