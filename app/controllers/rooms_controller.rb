class RoomsController < ApplicationController
  before_action :authenticate_user!

  def show
    @room = Room.find(params[:id])
    @messages = @room.messages
    @message = current_user.messages.build
  end
end
