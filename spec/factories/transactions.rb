FactoryBot.define do
  factory :transaction do
    wallet_origin { nil }
    wallet_destiny { nil }
    card_origin { nil }
    card_destiny { nil }
    amount { "9.99" }
    percentage { "9.99" }
    fixed { "9.99" }
  end
end
