class Card < ApplicationRecord
  # belongs_to :customer #to be done later
  has_many :card_origin_transaction, class_name: 'Transaction', foreign_key: 'card_origin'
  has_many :card_destiny_transaction, class_name: 'Transaction', foreign_key: 'card_destiny'

  # validates_associated :customer
  validates :name, :name_on_card, :number, :expiry, presence: true
  validates :debit, inclusion: { in: [true, false] }
  validates :number, format: { with: /\d{16}/ }
  validate :valid_expiration

  def valid_expiration
    if expiry.is_a?(Date)
      errors.add(:expiry, 'must be a valid date in the future') unless expiry > Date.today
    else
      errors.add(:expiry, 'must be a valid date')
    end
  end
end
