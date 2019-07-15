# frozen_string_literal: true

class AuthorizeRequest
  def initialize(headers = {})
    @headers = headers
  end

  def call
    {
      user: user
    }
  end

  private

  attr_reader :headers

  def user
    @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
  rescue ActiveRecord::RecordNotFound => err
    raise(
      ExceptionHandler::InvalidToken,
      (Message.invalid_token + err.message)
    )
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    return headers['Authorization'].split(' ').last if headers['Authorization'].present?
    raise(ExceptionHandler::MissingToken, Message.missing_token)
  end
end
