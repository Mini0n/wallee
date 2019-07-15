class AuthUser
  def initialize(email, pass)
    @email = email
    @pass = pass
  end

  def call
    JsonWebToken.encode(user_id: user.id) if user
  end

  private

  attr_reader :email, :pass

  def user
    user = User.find_by(email: email)
    return user if user && user.authenticate(pass)
    raise(ExceptionHandler::AuthError, Message.invalid_credentials)
  end
end