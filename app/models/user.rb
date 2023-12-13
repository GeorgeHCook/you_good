class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :check_ins, dependent: :destroy
  has_many :chatrooms_as_participant_one, class_name: "Chatroom", foreign_key: "participant_one_id", dependent: :destroy
  has_many :chatrooms_as_participant_two, class_name: "Chatroom", foreign_key: "participant_two_id", dependent: :destroy
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  include PgSearch::Model
  pg_search_scope :search_by_first_name_and_email,
                  against: %i[first_name email],
                  using: {
                    tsearch: { prefix: true }
                  }
end
