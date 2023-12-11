class RenameMediaIdToVideoId < ActiveRecord::Migration[7.1]
  def change
    rename_column :media, :media_id, :video_id
  end
end
