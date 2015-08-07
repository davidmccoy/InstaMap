class MapsController < ApplicationController

  def show

    @user = User.find(params[:user_id])
    @map = Map.find(params[:id])

  end
end