class User < ApplicationRecord
  # ecrypted pass
  has_secure_password

  has_one :wallet
  # has_many :cards

  validates_presence_of :name, :email, :password_digest
end
