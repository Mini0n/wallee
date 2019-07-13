# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Transactions API', type: :request do
  let!(:transactions) { create_list(:transaction, 10) }
  let(:transaction_id) { transactions.first.id }
  let(:wallet_id) { transactions.first.wallet_origin_id }

  describe 'GET /transactions' do
    before { get "/wallets/#{wallet_id}/transactions" }

    it 'returns transactions' do
      expect(json).not_to be_empty
      expect(json.size).to eq 10
    end

    it 'returns status 200' do
      expect(response).to have_http_status 200
    end
  end

  describe 'GET /transactions/:id' do
    before { get "/wallets/#{wallet_id}/transactions/#{transaction_id}" }

    context 'transaction exists' do
      it 'returns transaction' do
        expect(json).not_to be_empty
        expect(json['id']).to eq transaction_id
      end

      it 'returns status 200' do
        expect(response).to have_http_status 200
      end
    end

    context 'transaction doesnt exists' do
      let(:transaction_id) { 3434 }

      it 'returns status 404' do
        expect(response).to have_http_status 404
      end

      it 'returns error message' do
        expect(response.body).to include "Couldn't find Transaction"
      end
    end
  end
end
