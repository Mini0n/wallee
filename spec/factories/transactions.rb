# frozen_string_literal: true

FactoryBot.define do
  factory :transaction do
    # wallet_origin { nil } # factory: :wallet
    # wallet_destiny { nil }
    wallet_origin factory: :wallet # factory: :wallet
    wallet_destiny factory: :wallet
    card_origin { nil }
    card_destiny { nil }
    amount { rand(1.0...11.0).round(2) }
    percentage { rand(1.0...11.0).round(2) }
    fixed { rand(1.0...11.0).round(2) }
  end
end
