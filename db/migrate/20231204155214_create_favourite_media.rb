class CreateFavouriteMedia < ActiveRecord::Migration[7.1]
  def change
    create_table :favourite_media do |t|
      t.references :check_in, null: false, foreign_key: true
      t.references :medium, null: false, foreign_key: true

      t.timestamps
    end
  end
end
