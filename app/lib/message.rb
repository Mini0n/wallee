class Message
  def self.not_fount(record = 'record')
    "#{record} Not found"
  end

  def self.invalid_credentials
    'Invalid Credentials'
  end

  def self.invalid_token
    'Invalid Token'
  end

  def self.missing_token
    'Missing Token'
  end

  def self.unauthorized
    'Unauthorized request. Ah, ah, ah. You didnt say the magic word'
  end

  def self.account_created
    'Account created'
  end

  def self.account_not_created
    'Account Not Created'
  end

  def self.expired_token
    'Token Expired. Login Again'
  end

  def self.no_admin
    'System not correctly configured'
  end
end
