# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { 'ola@kase.com' }
    password { 'test' }
    # wallet { nil }
    wallet factory: :wallet
  end
end
