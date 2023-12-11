class AddUserIdToChatrooms < ActiveRecord::Migration[7.1]
  def change
    add_column :chatrooms, :user_id, :integer
  end
end
