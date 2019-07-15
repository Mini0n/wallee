# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Wallets API', type: :request do
  let(:user) { create(:user) }
  let(:headers) { valid_headers }

  let(:wallet_id) { user.wallet.id }

  describe 'GET /wallets' do
    before { get '/wallets', headers: headers }

    it 'returns wallets' do
      expect(json).not_to be_empty
      # expect(json.size).to eq 1
    end

    it 'returns status 200' do
      expect(response).to have_http_status 200
    end
  end

  describe 'GET /wallets/:id' do
    before { get "/wallets/#{wallet_id}", headers: headers }

    context 'wallet exists' do
      it 'returns wallet' do
        expect(json).not_to be_empty
        expect(json['id']).to eq wallet_id
      end

      it 'returns status 200' do
        expect(response).to have_http_status 200
      end
    end

    context 'wallet doesnt exists' do
      before { get "/wallets/1235", headers: headers }

      it 'returns status 404' do
        expect(response).to have_http_status 204
      end
    end

    context 'no auth token' do
      before { get "/wallets/#{wallet_id}", headers: invalid_headers }

      it 'returns status 404' do
        expect(response).to have_http_status 401
      end
    end
  end
end
