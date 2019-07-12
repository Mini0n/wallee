class Transaction < ApplicationRecord
  belongs_to :wallet_origin, class_name: 'Wallet', optional: true
  belongs_to :wallet_destiny, class_name: 'Wallet', optional: true
  belongs_to :card_origin, class_name: 'Card', optional: true
  belongs_to :card_destiny, class_name: 'Card', optional: true

  validates :amount, :percentage, :fixed, numericality: true, presence: true
end
