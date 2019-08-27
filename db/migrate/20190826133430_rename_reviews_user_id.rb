class RenameReviewsUserId < ActiveRecord::Migration[5.2]
  def change
    rename_column :reviews, :host_review_id, :host_id
    rename_column :reviews, :guest_review_id, :guest_id
  end
end
