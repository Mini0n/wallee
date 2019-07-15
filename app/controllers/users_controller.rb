class UsersController < ApplicationController

  # POST /signup
  def create
    user = User.create!(user_params)
    auth_token = AuthUser.new(user.email, user.password).call
    response = { message: Message.account_created, auth_token: auth_token }
    json_response(response, :created)
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end