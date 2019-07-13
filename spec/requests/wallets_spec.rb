# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Wallets API', type: :request do
  let!(:wallets) { create_list(:wallet, 10) }
  let(:wallet_id) { wallets.first.id }

  describe 'GET /wallets' do
    before { get '/wallets' }

    it 'returns wallets' do
      expect(json).not_to be_empty
      expect(json.size).to eq 10
    end

    it 'returns status 200' do
      expect(response).to have_http_status 200
    end
  end

  describe 'GET /wallets/:id' do
    before { get "/wallets/#{wallet_id}" }

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
      let(:wallet_id) { 1235 }

      it 'returns status 404' do
        expect(response).to have_http_status 404
      end

      it 'returns error message' do
        expect(response.body).to include "Couldn't find Wallet"
      end
    end
  end
end
