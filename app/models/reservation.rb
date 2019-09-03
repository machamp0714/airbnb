class Reservation < ApplicationRecord
  enum status: { Waiting: 0, Approved: 1, Dicline: 2 }

  after_create_commit :create_notification

  belongs_to :user
  belongs_to :room

  private
    def create_notification
      type = self.room.Instant? ? "New Booking" : "New Request"
      guest = User.find(self.user_id)

      Notification.create(content: "#{type} from #{guest.name}", user_id: self.room.user_id)
    end
end
