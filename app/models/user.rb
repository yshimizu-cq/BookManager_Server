class User < ApplicationRecord
  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true,
                    length: { maximum: 255 },
                    uniqueness: true,
                    format: { with: VALID_EMAIL_REGEX }

  validates :password, presence: true,
                       length: { minimum: 6 }
  has_secure_password
  has_secure_token
end
