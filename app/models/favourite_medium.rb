class FavouriteMedium < ApplicationRecord
  belongs_to :check_in
  belongs_to :medium
end
