# frozen_string_literal: true

class Card < ApplicationRecord
  include ActiveModel::Validations
  belongs_to :user, optional: true

  has_many :card_origin_transaction, class_name: 'Transaction', foreign_key: 'card_origin'
  has_many :card_destiny_transaction, class_name: 'Transaction', foreign_key: 'card_destiny'

  # validates_associated :customer
  validates :name, :name_on_card, :number, :expiry, presence: true
  validates :number, credit_card_number: true
  validates :debit, inclusion: { in: [true, false] }
  validate :valid_expiration

  validates :name, uniqueness: { scope: :user, message: "There's already a Card with this name" }
  validates :number, uniqueness: { scope: :user, message: "There's already a Card with this number" }

  def valid_expiration
    if expiry.is_a?(Date)
      errors.add(:expiry, 'must be a valid date in the future') unless expiry > Date.today
    else
      errors.add(:expiry, 'must be a valid date')
    end
  end
end
