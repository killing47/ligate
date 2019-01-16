class CdsController < ApplicationController

  def create
    cd = Cd.new(cd_params)
    cd.user_id = current_user.id
    cd.save
    redirect_to user_path(current_user.id)
  end

  def update
  end

  def destroy
  end

  private

  def cd_params
    params.require(:cd).permit(:user_id,:cd_title, :cd_imgage, :cd_genre, musics_attributes: [:id, :cd_id, :audio, :music_title, :_destroy])
  end
end
