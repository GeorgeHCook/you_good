class RemoveColumnsFromMedia < ActiveRecord::Migration[7.1]
  def change
    remove_column :media, :category, :string
    remove_column :media, :artwork_url, :string
    remove_column :media, :title, :string
    remove_column :media, :media_url, :string
  end
end
