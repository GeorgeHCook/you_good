class CreateMedia < ActiveRecord::Migration[7.1]
  def change
    create_table :media do |t|
      t.string :title
      t.string :category
      t.string :media_type
      t.string :media_url
      t.string :artwork_url

      t.timestamps
    end
  end
end
