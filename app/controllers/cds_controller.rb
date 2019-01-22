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

  def fav
    cd = Cd.find(params[:id])
    if cd.favorited_by?(current_user)
      fav = current_user.favorites.find_by(cd_id: cd.id)
      fav.destroy
      @user = current_user
      cd_titles = current_user.favorites.map{|fav| fav.cd.cd_title}
      #render json: cd
      render json: {:cd => cd ,:@user => @user,:cd_titles => cd_titles}
    else
      fav = current_user.favorites.new(cd_id: cd.id)
      fav.save
      @user = current_user
      cd_titles = current_user.favorites.map{|fav| fav.cd.cd_title}
    #  render json: cd
      render json: {:cd => cd ,:@user => @user,:cd_titles => cd_titles}
    end
  end

  def op_cd
    cd = Cd.find(params[:id])
    render partial: 'partial/cd.show', locals: { :cd => cd }
  end

  private

  def cd_params
    params.require(:cd).permit(:user_id,:cd_title, :cd_imgage, :cd_genre, musics_attributes: [:id, :cd_id, :audio, :music_title, :_destroy])
  end
end
