class AddIndexConversationsSenderIdRecipientId < ActiveRecord::Migration[5.2]
  def change
    add_index :conversations, [:sender_id, :recipient_id]
  end
end
