class User < ApplicationRecord
  before_save { username.downcase! }
  validates :name, length: { maximum: 50 }
  validates :username, presence: true, length: { maximum: 30 },
                        uniqueness: { case_sensitive: false }
  has_secure_password
  VALID_PWD_REGEX = /\A(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])/
  validates :password, presence: true, length: { in: 8..30 },
                        format: { with: VALID_PWD_REGEX }
end
