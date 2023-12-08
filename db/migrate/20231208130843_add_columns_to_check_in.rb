class AddColumnsToCheckIn < ActiveRecord::Migration[7.1]
  def change
    add_column :check_ins, :music_content, :string
    add_column :check_ins, :video_content, :string
    add_column :check_ins, :details_content, :text
  end
end
