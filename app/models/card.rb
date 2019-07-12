class Card < ApplicationRecord
  # belongs_to :customer #to be done later
  # validates_associated :customer

  validates :name, :name_on_card, :number, :expiry, :debit, presence: true
  validates :number, format: { with: /\d{16}/ }
  validate :valid_expiration

  def valid_expiration
    expiry.is_a?(Date) && expiry > Date.today
  end
end
