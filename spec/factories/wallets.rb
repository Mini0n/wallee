FactoryBot.define do
  factory :wallet do
    balance { rand(1.0...11.0).round(2) }
  end
end
