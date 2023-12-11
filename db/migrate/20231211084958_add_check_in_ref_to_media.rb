class AddCheckInRefToMedia < ActiveRecord::Migration[7.1]
  def change
    add_reference :media, :check_in, foreign_key: true
  end
end
