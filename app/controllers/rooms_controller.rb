class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_search

  def show
    @room = Room.find(params[:id])
    @messages = @room.messages
    @message = current_user.messages.build
  end
end
