# frozen_string_literal: true

class Comission < ApplicationRecord
  validates :lower_limit, :upper_limit, :percentage, :fixed,
            numericality: { greater_than_or_equal_to: 0 }, presence: true
  validate :valid_limits

  def valid_limits
    (errors.add(:lower_limit, 'must be less than upper_limit') if lower_limit >= upper_limit) if
      lower_limit && upper_limit
  end
end
