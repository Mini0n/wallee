class Comission < ApplicationRecord

  validates :lower_limit, :upper_limit, :percentage, :fixed,
            numericality: { greater_than_or_equal_to: 0 }, presence: true
end
