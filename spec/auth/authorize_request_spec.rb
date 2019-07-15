# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthorizeRequest do
  let(:user) { create(:user) }
  let(:header) { { 'Auth' => token_generator(user.id) } }

  subject(:bad_request) { AuthorizeRequest.new({}) }
  subject(:yes_request) { AuthorizeRequest.new(header) }

  describe '#call' do
    context 'when valid request' do
    end

    context 'when invalid request' do
    end
  end
end
