# frozen_string_literal: true

class Transaction < ApplicationRecord
  belongs_to :wallet_origin, class_name: 'Wallet', optional: true
  belongs_to :wallet_destiny, class_name: 'Wallet', optional: true

  belongs_to :card_origin, class_name: 'Card', optional: true
  belongs_to :card_destiny, class_name: 'Card', optional: true

  validates :amount, numericality: { greater_than_or_equal_to: 0 }, presence: true

  validate :valid_operation

  # Valid operations:
  # wallet_origin -> wallet_destiny
  # wallet_origin -> card_destiny
  # card_origin -> wallet_destiny (wallet of user)
  def valid_operation
    if (wallet_origin && wallet_destiny ||
        wallet_origin && card_destiny && card_destiny.debit ||
        card_origin && wallet_destiny).nil?
      errors.add(:amount, 'invalid operation. Missing wallet(s) and/or card(s)')
    end
  end
end
