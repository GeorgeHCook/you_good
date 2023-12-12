class Chatroom < ApplicationRecord
  has_many :messages, dependent: :destroy
  belongs_to :participant_one, class_name: "User"
  belongs_to :participant_two, class_name: "User"
end
