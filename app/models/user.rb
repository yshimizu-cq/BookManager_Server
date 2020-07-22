class User < ApplicationRecord
  before_save { email.downcase! } # 破壊的メソッド
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true,
                    length: { maximum: 255 },
                    uniqueness: true,
                    format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true,
                       length: { minimum: 6 }
  has_many :books
  has_secure_password
end
