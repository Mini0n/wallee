FactoryBot.define do
  factory :card do
    name { Faker::Name.name }
    name_on_card { Faker::Name.name }
    number { CreditCardValidations::Factory.random }
    expiry { Date.today + rand(1..1000) }
    debit { [true, false].sample }
  end
end
