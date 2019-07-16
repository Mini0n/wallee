# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Transactions API', type: :request do
  let!(:user_admin){ create(:user, id: 0) }
  let(:user) { create(:user) }
  let(:user_2) { create(:user) }
  let(:headers) { valid_headers }

  let(:card_credit) { create(:card, debit: false, user: user) }
  let(:card_debit) { create(:card, debit: true, user: user) }

  let!(:transactions) do
    create_list(:transaction, 10,
                amount: 1000,
                wallet_origin_id: user.wallet.id,
                wallet_destiny_id: user_2.wallet.id)
  end

  let!(:wallet_id) { user.wallet.id }

  let!(:transactions_to_card) do
    create_list(
      :transaction, 10,
      amount: 1000,
      wallet_origin_id: wallet_id,
      wallet_destiny_id: nil,
      card_destiny: card_debit
    )
  end
  let!(:transactions_from_card) do
    create_list(
      :transaction, 10,
      amount: 1000,
      wallet_origin_id: nil,
      wallet_destiny_id: wallet_id,
      card_origin: card_credit
    )
  end

  let(:transaction_id) { transactions.first.id }
  let(:transaction_from_card_id) { transactions_from_card.first.id }
  let(:transaction_to_card_id) { transactions_to_card.first.id }

  describe 'GET /transactions' do
    context 'wallet to wallet' do
      before { get "/transactions", headers: headers }

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
      before { get "/transactions", headers: headers }

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
      before { get "/transactions", headers: headers }

      it 'returns transactions' do
        expect(json).not_to be_empty
        expect(json.size).to eq 30
        expect(json[21]['card_origin_id']).to be_truthy
        expect(json[21]['wallet_destiny_id']).to be_truthy
      end

      it 'returns status 200' do
        expect(response).to have_http_status 200
      end
    end
  end

  describe 'GET /transactions/:id' do
    before { get "/wallets/#{wallet_id}/transactions/#{transaction_id}", headers: headers }

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

    context 'wallet to wallet' do
      let(:params) do
        {
          amount: 100,
          wallet_origin_id: wallet_id,
          wallet_destiny_id: user_2.wallet.id
        }
      end
      context 'successful transfer' do
        before { post '/transactions', params: params.to_json, headers: headers }

        it 'returns status 200' do
          expect(json['fixed']).not_to be_nil
          expect(response).to have_http_status 200
        end
      end

      context 'invalid destiny wallet' do
        before { post '/transactions', params: params.merge({wallet_destiny_id: 1234}).to_json, headers: headers }

        it 'returns status 422' do
          expect(json['fixed']).to be_nil
          expect(response).to have_http_status 422
        end
      end

      context 'invalid origin wallet' do
        before { post '/transactions', params: params.merge({wallet_origin_id: user_2.wallet.id}).to_json, headers: headers }

        it 'returns status 422' do
          expect(json['fixed']).to be_nil
          expect(response).to have_http_status 422
        end
      end

      context 'unsufficient funds' do
        before { post '/transactions', params: params.merge({amount: 1000}).to_json, headers: headers }

        it 'returns status 422' do
          expect(json['fixed']).to be_nil
          expect(response).to have_http_status 422
        end
      end

    end

    context 'wallet to credit card' do
      let(:params) do
        {
          amount: 100,
          wallet_origin_id: wallet_id,
          card_destiny_id: card_credit.id
        }
      end

      context 'wallet to card (credit)' do
        before { post '/transactions', params: params.to_json, headers: headers }

        it 'returns status 422' do
          expect(json['error']).to include 'invalid operation'
          expect(response).to have_http_status 422
        end
      end
    end
  end
end
