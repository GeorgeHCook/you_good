class ChatroomsController < ApplicationController
  def show
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
  end

  def create
    @chatroom = Chatroom.find_by(participant_one: current_user, participant_two: User.find(params[:user_id]))
    @chatroom = Chatroom.find_by(participant_one: User.find(params[:user_id]), participant_two: current_user)
    unless @chatroom
      @chatroom = Chatroom.create(participant_one: current_user, participant_two: User.find(params[:user_id]))
    end
    redirect_to chatroom_path(@chatroom)
  end

  def index
    @chatrooms = Chatroom.where(participant_one: current_user).or(Chatroom.where(participant_two: current_user))
    @chatroom = Chatroom.where(participant_one: current_user, participant_two: current_user)
    @users = []
    @users = User.search_by_first_name_and_email(params[:query]) if params[:query].present?
  end
end
