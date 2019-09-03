class Notification < ApplicationRecord
  after_create_commit { NotificationJob.perform_later self } # perform_later?

  belongs_to :user
end
