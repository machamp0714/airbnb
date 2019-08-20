# frozen_string_literal: true

class Photo < ApplicationRecord
  belongs_to :room
  mount_uploader :image, PhotoUploader
end
