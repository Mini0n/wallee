# frozen_string_literal: true

class Wallet < ApplicationRecord
  # belongs_to :customer #to be done later
  has_many :wallet_origin_transaction, class_name: 'Transaction', foreign_key: 'wallet_origin'
  has_many :wallet_destiny_transaction, class_name: 'Transaction', foreign_key: 'wallet_destiny'

  has_many :card_origin_transaction, class_name: 'Transaction', foreign_key: 'card_origin'
  has_many :card_destiny_transaction, class_name: 'Transaction', foreign_key: 'card_destiny'

  # validates_associated :customer
  validates :balance, numericality: true, presence: true
end
