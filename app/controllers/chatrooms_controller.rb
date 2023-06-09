class ChatroomsController < ApplicationController
  def index
    @chatrooms = Chatroom.joins(:participants)
                         .where(participants: { user_id: current_user.id })
  end

  def show
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
  end

  def create
    @user = User.find(params_chatroom_user[:user])
    @current_user = current_user
    @room = Chatroom.new
    @room_name = get_name(@user, @current_user)
    @single_room = Chatroom.where(name: @room_name).first || Chatroom.create_private_room([@user, @current_user], @room_name)
    @messages = @single_room.messages
    redirect_to chatroom_path(@single_room)
  end

  def new
    create
  end

  def destroy
    @chatroom = Chatroom.find(params[:id])
    @chatroom.destroy
    redirect_to chatrooms_path, status: :see_other
  end

  private

  def get_name(user1, user2)
    users = [user1, user2].sort
    "Message #{users[0].id}_#{users[1].id}"
  end

  def params_chatroom_user
    params.permit(:user)
  end
end
