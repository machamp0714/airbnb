class Review < ApplicationRecord
  belongs_to :room
  belongs_to :reservation
  belongs_to :host
  belongs_to :guest

end
