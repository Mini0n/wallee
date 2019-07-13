# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comission, type: :model do
  it { should validate_presence_of(:lower_limit) }
  it { should validate_presence_of(:upper_limit) }
  it { should validate_presence_of(:percentage) }
  it { should validate_presence_of(:fixed) }

  it { should validate_numericality_of(:lower_limit) }
  it { should validate_numericality_of(:upper_limit) }
  it { should validate_numericality_of(:percentage) }
  it { should validate_numericality_of(:fixed) }
end
