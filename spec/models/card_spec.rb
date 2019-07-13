# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Card, type: :model do
  # Association tests
  it { should have_many(:card_origin_transaction).with_foreign_key 'card_origin' }
  it { should have_many(:card_destiny_transaction).with_foreign_key 'card_destiny' }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:name_on_card) }
  it { should validate_presence_of(:number) }
  it { should validate_presence_of(:expiry) }
end
