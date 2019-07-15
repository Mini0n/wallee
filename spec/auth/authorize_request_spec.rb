# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthorizeRequest do
  let(:user) { create(:user) }
  let(:header) { { 'Auth' => token_generator(user.id) } }

  subject(:bad_request) { AuthorizeRequest.new({}) }
  subject(:yes_request) { AuthorizeRequest.new(header) }

  describe '#call' do
    context 'when valid request' do
      it 'returns User' do
        result = yes_request.call
        expect(result[:user]).to eq user
      end
    end

    context 'when invalid request' do
      it 'raises MissingToken' do
        expect { bad_request.call }
          .to raise_error(ExceptionHandler::MissingToken)
      end

      context 'Invalid Token' do
        let(:bad_header) { { 'Auth' => token_generator(1111) } }
        subject(:bad_request) { AuthorizeRequest.new(bad_header) }

        it 'raises InvalidToken' do
          expect { bad_request.call }
            .to raise_error(ExceptionHandler::InvalidToken)
        end
      end

      context 'Expired Token' do
        let(:bad_header) { { 'Auth' => token_generator_expired(user.id) } }
        subject(:bad_request) { AuthorizeRequest.new(bad_header) }

        it 'raises Invalid Token' do
          expect { bad_request.call }
            .to raise_error(ExceptionHandler::InvalidToken, /Signature has expired/)
        end
      end

      context 'Fake token' do
        let(:bad_header) { { 'Auth' => 'this-is-not-a-valid-token' } }
        subject(:bad_request) { AuthorizeRequest.new(bad_header) }

        it 'handles JWT::DecodeError' do
          expect { bad_request.call }
            .to raise_error(ExceptionHandler::InvalidToken, /Not enough or too many segments/)
        end
      end
    end
  end
end
