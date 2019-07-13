# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Cards API', type: :request do
  let!(:cards) { create_list(:card, 10) }
  let(:card_id) { cards.first.id }

  describe 'GET /cards' do
    before { get '/cards' }

    it 'returns cards' do
      expect(json).not_to be_empty
      expect(json.size).to eq 10
    end

    it 'returns status code 200' do
      expect(response).to have_http_status 200
    end
  end

  describe 'POST /cards' do
    # valid params
    let(:valid_params) do
      {
        name: Faker::Business.credit_card_type,
        name_on_card: Faker::Name.name,
        number: CreditCardValidations::Factory.random(:visa),
        expiry: Date.today + rand(1..1000),
        debit: [true, false].sample
      }
    end

    context 'when request is valid' do
      before { post '/cards', params: valid_params }

      it 'creates a new card' do
        expect(json['number']).to eq valid_params[:number]
      end

      it 'returns status code 201' do
        expect(response).to have_http_status 201
      end
    end

    context 'when request is invalid' do
      before { post '/cards', params: { name: 'invalid' } }

      it 'returns status code 422' do
        expect(response).to have_http_status 422
      end

      it 'returns error message' do
        expect(response.body).to include 'Number is invalid'
      end
    end
  end

  describe 'GET /cards/:id' do
    before { get "/cards/#{card_id}" }

    context 'card exists' do
      it 'returns card' do
        expect(json).not_to be_empty
        expect(json['id']).to eq card_id
      end

      it 'returns status code 200' do
        expect(response).to have_http_status 200
      end
    end

    context 'card doesnt exists' do
      let(:card_id) { 1111 }

      it 'returns status code 404' do
        expect(response).to have_http_status 404
      end

      it 'returns error message' do
        expect(response.body).to include "Couldn't find Card"
      end
    end
  end

  describe 'PUT /cards:id' do
    let(:valid_params) { { name_on_card: Faker::Name.name } }

    context 'when card exists' do
      before { put "/cards/#{card_id}", params: valid_params }

      it 'updates card' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status 204
      end
    end
  end

  describe 'DELETE /cards/:id' do
    before { delete "/cards/#{card_id}" }

    context 'when card is deleted' do
      it 'returns status code 204' do
        expect(response).to have_http_status 204
      end
    end
  end
end
