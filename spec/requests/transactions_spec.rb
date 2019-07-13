require 'rails_helper'

RSpec.describe 'Transactions API', type: :request do
  let!(:transactions) { create_list(:transaction, 10) }
  let(:transaction_id) { transactions.first.id }

  describe 'GET /transactions' do
    before { get '/transactions' }

    it 'returns transactions' do
      expect(json).not_to be_empty
      expect(json.size).to eq 10
    end

    it 'returns status 200' do
      expect(response).to have_http_status 200
    end
  end

  describe 'GET /transactions/:id' do
    before { get "/transactions/#{transaction_id}" }

    context 'transaction exists' do
      it 'returns transaction' do
        expect(json).not_to be_empty
        expect(json['id']).to eq todo_id
      end

      it 'returns status 200' do
        expect(response).to have_http_status 200
      end
    end

    context 'transaction doesnt exists' do
      it 'returns status 404' do
        expect(response).to have_http_status 404
      end

      it 'returns error message' do
        expect(response.body).to include 'The transaction does not exists'
      end
    end
  end
end