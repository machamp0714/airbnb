class User < ApplicationRecord
  attr_accessor :remember_token

  before_save { self.email = email.downcase }

  has_secure_password

  validates :name,
    presence: true,
    uniqueness: true

  validates :email,
    presence: true,
    uniqueness: { case_sensitive: false }

  validates :password,
    presence: true,
    length: { minimum: 8 }

    def self.digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    def self.new_token
      SecureRandom.urlsafe_base64
    end

    def remember
      self.remember_token = User.new_token
      update_attribute(:remember_digest, User.digest(self.remember_token))
    end
end
