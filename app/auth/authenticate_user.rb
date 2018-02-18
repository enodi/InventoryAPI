class AuthenticateUser
  def initialize(email, password)
    @email = email
    @password = password
  end

  def call(user_id)
    JsonWebToken.encode(user_id: user_id)
  end

  private

  attr_reader :email, :password

  def user
    user = User.find_by(email: email)
    return user if user && user.authenticate(password)
    raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
  end
end