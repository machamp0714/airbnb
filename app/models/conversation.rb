class Conversation < ApplicationRecord
  belongs_to :sender, foreign_key: :sender_id, class_name: "User"
  belongs_to :recipient, foreign_key: :recipient_id, class_name: "User"

  has_many :messages, dependent: :destroy

  validates :sender_id, uniqueness: true
  validates :recipient_id, uniqueness: true

  def self.involving(user)
    where("sender_id = ? OR recipient_id = ?", user.id, user.id)
  end

  def self.between(user_A, user_B)
    where("(sender_id = ? OR recipient_id = ?) OR (sender_id = ? OR recipient_id = ?)", user_A, user_B, user_B, user_A)
  end

end
