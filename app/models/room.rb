class Room < ApplicationRecord
  belongs_to :user
  has_many :photos

  validates :home_type, presence: true
  validates :room_type, presence: true
  validates :accommodate, presence: true
  validates :bed_room, presence: true
  validates :bath_room, presence: true

  def is_ready?
    !active && !price.blank? && !listing_name.blank? && !photos.blank? && !address.blank?
  end
end
