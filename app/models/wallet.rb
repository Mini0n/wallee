class Wallet < ApplicationRecord
  # belongs_to :customer #to be done later
  # has_many :transaction

  # validates_associated :customer
  validates :balance, numericality: true, presence: true

end
