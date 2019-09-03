class Message < ApplicationRecord
  belongs_to :user
  belongs_to :conversation

  validates :content, presence: true
  validates :user_id, presence: true
  validates :conversation_id, presence: true

  def message_time
    self.created_at.strftime("%v")
  end
end
