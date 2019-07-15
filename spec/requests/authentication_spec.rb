require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  describe 'POST /auth/login' do
    let!(:user) { create(:user) }
    let(:headers) { valid_headers.except('Authorization') }
    let(:valid_creds) do
      {
        email: user.email,
        password: user.password
      }.to_json
    end
    let(:invalid_creds) do
      {
        email: Faker::Internet.email,
        password: 'invalid-pass'
      }.to_json
    end

    context 'when request is valid' do
      before { post '/auth/login', params: valid_creds, headers: headers }

      it 'returns an authentication token' do
        expect(json['auth_token']).not_to be_nil
      end
    end

    context 'when request is invalid' do
      before { post '/auth/login', params: invalid_creds, headers: headers }

      it 'returns fail message' do
        expect(json['message']).to match /Invalid Credentials/
      end
    end
  end
end