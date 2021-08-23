class User < ApplicationRecord
  before_save { self.email = email.downcase }

  Valid_email_regex = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :email, presence: true, uniqueness: true, format: { with: Valid_email_regex }

  validates :username, presence: true, uniqueness: true, length: { minimum: 2, maximum: 20 }

  has_secure_password
  validates :password, presence: true, length: { minimum: 8 }
end
