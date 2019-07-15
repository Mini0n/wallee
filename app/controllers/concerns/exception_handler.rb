# frozen_string_literal: true

module ExceptionHandler
  extend ActiveSupport::Concern

  # Define custom error subclasses - rescue catches `StandardErrors`
  class AuthError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end

  included do
    # Define custom handlers
    rescue_from ActiveRecord::RecordInvalid, with: :unprocessable

    rescue_from ExceptionHandler::AuthError, with: :bad_token
    rescue_from ExceptionHandler::MissingToken, with: :bad_token
    rescue_from ExceptionHandler::InvalidToken, with: :bad_token

    rescue_from ActiveRecord::RecordNotFound do |er|
      json_response({ error: er.message.slice(0, er.message.index(' with')) }, :not_found)
    end
  end

  private

  def bad_token(e)
    json_response({ message: e.message }, :unauthorized)
  end

  def unprocessable(e)
    json_response({message: e.message}, :unprocessable_entity)
  end

end
