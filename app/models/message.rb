class Message < ApplicationRecord
  belongs_to :chatroom
  belongs_to :user
end
def sender?(user_to_compare)
  user.same?(user_to_compare)
 end
