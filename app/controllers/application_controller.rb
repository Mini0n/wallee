# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

  before_action :authorize_request
  attr_reader :current_user, :admin_user

  private

  def authorize_request
    @current_user = AuthorizeRequest.new(request.headers).call[:user]
  end

  def admin_user
    @admin_user ||= User.find(0)
  rescue ActiveRecord::RecordNotFound => err
    raise(
      ExceptionHandler::NoAdminUser,
      (Message.no_admin)
    )
  end
end
