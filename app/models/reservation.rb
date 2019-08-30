class Reservation < ApplicationRecord
  enum status: { Waiting: 0, Approved: 1, Dicline: 2 }

  belongs_to :user
  belongs_to :room
end
