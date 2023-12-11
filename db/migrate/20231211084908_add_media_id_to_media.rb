class AddMediaIdToMedia < ActiveRecord::Migration[7.1]
  def change
    add_column :media, :media_id, :string
  end
end
