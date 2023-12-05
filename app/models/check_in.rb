class CheckIn < ApplicationRecord
  belongs_to :user
end

class Article < ApplicationRecord
  has_one_attached :photo
end
