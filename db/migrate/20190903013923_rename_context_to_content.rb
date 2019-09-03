class RenameContextToContent < ActiveRecord::Migration[5.2]
  def change
    rename_column :messages, :context, :content
  end
end
