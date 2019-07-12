FactoryBot.define do
  factory :card do
    name { "MyString" }
    name_on_card { "MyString" }
    number { "MyString" }
    expiry { "2019-07-12" }
    debit { false }
  end
end
