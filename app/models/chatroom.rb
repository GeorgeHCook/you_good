class Chatroom < ApplicationRecord
  has_many :messages
  belongs_to :participant_one, class_name: "User"
  belongs_to :participant_two, class_name: "User"
end
