class User < ApplicationRecord

    before_save { self.email = email.downcase }

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

    validates :email, presence: true, uniqueness: true, format: {with: VALID_EMAIL_REGEX}

    validates :username, presence: true, uniqueness: true , length: {minimum: 2, maximum: 20} 

    has_secure_password
    validates :password, presence: true, length: {minimum: 8 }
end
