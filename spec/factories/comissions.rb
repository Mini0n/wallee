# frozen_string_literal: true

FactoryBot.define do
  factory :comission do
    lower_limit { rand(1.0...11.0).round(2) }
    upper_limit { rand(1.0...11.0).round(2) }
    percentage { rand(1.0...11.0).round(2) }
    fixed { rand(1.0...11.0).round(2) }
  end
end
