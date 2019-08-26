# frozen_string_literal: true

class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token

  before_save :downcase_email
  before_create :create_activation_digest

  has_secure_password

  has_many :rooms, dependent: :destroy
  has_many :reservations, dependent: :destroy
  has_many :guest_reviews, class_name: "GuestReview", foreign_key: "guest_id", dependent: :destroy
  has_many :host_reviews, class_name: "HostReview", foreign_key: "host_id", dependent: :destroy

  validates :name,
    presence: true,
    uniqueness: true

  validates :email,
    presence: true,
    uniqueness: { case_sensitive: false }

  validates :password,
    presence: true,
    length: { minimum: 8 },
    allow_nil: true

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

    def authenticated?(attribute, token)
      digest = self.send("#{attribute}_digest")
      return false if digest.nil?
      BCrypt::Password.new(digest).is_password?(token)
    end

    def forget
      update_attribute(:remember_digest, nil)
    end

    def send_activation_email
      UserMailer.account_activation(self).deliver_now
    end

    def activate
      update(activated: true, activated_at: Time.zone.now)
    end

    private
      def downcase_email
        self.email = email.downcase
      end

      def create_activation_digest
        self.activation_token = User.new_token
        self.activation_digest = User.digest(activation_token)
      end
end
