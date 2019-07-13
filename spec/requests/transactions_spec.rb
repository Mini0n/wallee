# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Transactions API', type: :request do

  let(:card_credit) { create(:card, debit: false) }
  let(:card_debit) { create(:card, debit: true) }
  let(:user_1) { create(:user) }
  let(:user_2) { create(:user) }

  let!(:transactions) {
    create_list(:transaction, 10,
      wallet_origin_id: user_1.wallet.id,
      wallet_destiny_id: user_2.wallet.id
      )
    }

  let(:wallet_id) { transactions.first.wallet_origin_id }

  let!(:transactions_to_card) {
    create_list(
      :transaction, 10,
      wallet_origin_id: wallet_id,
      wallet_destiny_id: nil,
      card_destiny: card_debit
    )
  }
  let!(:transactions_from_card) {
    create_list(
      :transaction, 10,
      wallet_origin_id: nil,
      wallet_destiny_id: wallet_id,
      card_origin: card_credit
    )
  }

  let(:transaction_id) { transactions.first.id }
  let(:transaction_from_card_id) { transactions_from_card.first.id }
  let(:transaction_to_card_id) { transactions_to_card.first.id }

  describe 'GET /transactions' do
    context 'wallet to wallet' do
      before { get "/wallets/#{wallet_id}/transactions" }

      it 'returns transactions' do
        expect(json).not_to be_empty
        expect(json.size).to eq 30
        expect(json.first['wallet_origin_id']).to be_truthy
        expect(json.first['wallet_destiny_id']).to be_truthy
      end

      it 'returns status 200' do
        expect(response).to have_http_status 200
      end
    end

    context 'wallet to card' do
      before { get "/wallets/#{wallet_id}/transactions" }

      it 'returns transactions' do
        expect(json).not_to be_empty
        expect(json.size).to eq 30
        expect(json[11]['wallet_origin_id']).to be_truthy
        expect(json[11]['card_destiny_id']).to be_truthy
      end

      it 'returns status 200' do
        expect(response).to have_http_status 200
      end
    end

    context 'card to wallet' do
      before { get "/wallets/#{wallet_id}/transactions" }

      it 'returns transactions' do
        expect(json).not_to be_empty
        expect(json.size).to eq 30
        expect(json[23]['card_origin_id']).to be_truthy
        expect(json[23]['wallet_destiny_id']).to be_truthy
      end

      it 'returns status 200' do
        expect(response).to have_http_status 200
      end
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

  describe 'POST /transactions' do
    let(:valid_amounts) do
      { amount: 33.0, percentage: 2.0, fixed: 3.0 }
    end
    let(:wallet) { create(:wallet) }
    let(:credit) { create(:card, debit: false) }
    let(:debit) { create(:card, debit: true ) }

    context 'accepted movements' do
      it 'creates wallet to wallet' do
      end

      it 'creates wallet to card (debit)' do

      end

      it 'crates card to wallet' do

      end
    end

    context 'forbidden movements' do
    end
  end
end
