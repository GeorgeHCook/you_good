class AddMusicIdToMedia < ActiveRecord::Migration[7.1]
  def change
    add_column :media, :music_id, :string
  end
end
