class AddParticipantOneAndParticipantTwoToChatroom < ActiveRecord::Migration[7.1]
  def change
    add_reference :chatrooms, :participant_one, foreign_key: { to_table: :users }
    add_reference :chatrooms, :participant_two, foreign_key: { to_table: :users }
  end
end
