class CreateGroups < ActiveRecord::Migration[7.1]
  def change
    create_table :groups do |t|
      t.string :name
      t.string :location
      t.string :image_url
      t.string :category
      t.string :site_url

      t.timestamps
    end
  end
end
