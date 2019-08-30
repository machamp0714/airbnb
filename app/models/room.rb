# frozen_string_literal: true

class Room < ApplicationRecord
  enum instant: { Request: 0, Instant: 1 }

  belongs_to :user
  has_many :photos, dependent: :destroy
  has_many :reservations, dependent: :destroy
  has_many :guest_reviews, dependent: :destroy

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  validates :home_type, presence: true
  validates :room_type, presence: true
  validates :accommodate, presence: true
  validates :bed_room, presence: true
  validates :bath_room, presence: true

  def is_ready?
    !active && price.present? && listing_name.present? && photos.present? && address.present?
  end

  def cover_photo(size)
    if self.photos.length > 0
      self.photos[0].image_url(size)
    else
      "blank.jpg"
    end
  end

  def average_rating
    guest_reviews.count == 0 ? 0 : guest_reviews.average(:star).round(2).to_i
  end
end
