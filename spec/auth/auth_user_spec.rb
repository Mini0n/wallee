require 'rails_helper'

RSpec.describe AuthUser do
  let(:user) { create(:user) }
  subject(:valid_auth) { AuthUser.new(user.email, user.password) }
  subject(:invalid_auth) { AuthUser.new('not', 'valid') }

  describe '#call' do
    context 'when valid credentials' do
      it 'returns auth token' do
        token = valid_auth.call
        expect(token).not_to be_nil
      end
    end

    context 'when invalid credentials' do
      it 'raises authentication error' do
        expect { invalid_auth.call }
          .to raise_error(ExceptionHandler::AuthError, /Invalid Credentials/)
      end
    end
  end
end