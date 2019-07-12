require 'rails_helper'

RSpec.describe Wallet, type: :model do
  # Association tests
  it { should have_many(:wallet_origin_transaction).with_foreign_key 'wallet_origin' }
  it { should have_many(:wallet_destiny_transaction).with_foreign_key 'wallet_destiny' }
  it { should have_many(:card_origin_transaction).with_foreign_key 'card_origin' }
  it { should have_many(:card_destiny_transaction).with_foreign_key 'card_destiny' }

  it { should validate_presence_of(:balance) }
  it { should validate_numericality_of(:balance) }
end
