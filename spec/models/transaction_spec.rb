# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transaction, type: :model do
  # Association tests
  it { should belong_to(:wallet_origin).optional }
  it { should belong_to(:wallet_destiny).optional }
  it { should belong_to(:card_origin).optional }
  it { should belong_to(:card_destiny).optional }

  it { should validate_presence_of(:amount) }
  it { should validate_numericality_of(:amount) }
  it { should validate_numericality_of(:percentage) }
  it { should validate_numericality_of(:fixed) }
end
