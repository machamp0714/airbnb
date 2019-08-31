class Calendar < ApplicationRecord
  enum status: {Available: 0, Not_Available: 1}

  belongs_to :room

  validates :day, presence: true
end
