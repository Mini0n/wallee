# frozen_string_literal: true

class User < ApplicationRecord
  # ecrypted pass
  has_secure_password

  has_one :wallet
  has_many :cards

  validates_presence_of :name, :email, :password_digest
  validates :name, uniqueness: { case_sensitive: false, message: 'username already taken' }
  validates :email, uniqueness: { case_sensitive: false, message: 'email already taken' }
end
