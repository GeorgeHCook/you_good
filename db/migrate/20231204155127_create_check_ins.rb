class CreateCheckIns < ActiveRecord::Migration[7.1]
  def change
    create_table :check_ins do |t|
      t.integer :score
      t.text :details
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
