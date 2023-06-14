class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  validates_presence_of :password_digest

  has_secure_password

  before_create :generate_api_key

  # instance methods

  def generate_api_key
    self.api_key = SecureRandom.hex(13)
  end
end
