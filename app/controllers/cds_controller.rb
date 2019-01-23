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
    cd = Cd.find(params[:id])
    cd.destroy
    redirect_to user_path(current_user.id)
  end

  def fav
    cd = Cd.find(params[:id])
    if cd.favorited_by?(current_user)
      fav = current_user.favorites.find_by(cd_id: cd.id)
      fav.destroy
      user = current_user
      user_name = current_user.favorites.map{|u_n| u_n.cd .user.nick_name}.uniq
      cd_titles = current_user.favorites.map{|c_t| c_t.cd.cd_title}
      #render json: cd
      render :json =>{:cd => cd ,:user_name => user_name, :cd_titles => cd_titles}
    else
      fav = current_user.favorites.new(cd_id: cd.id)
      fav.save
      user = current_user
      user_name = current_user.favorites.map{|u_n| u_n.cd .user.nick_name}.uniq
      cd_titles = current_user.favorites.map{|c_t| c_t.cd.cd_title}
    #  render json: cd
      render :json => {:cd => cd ,:user_name => user_name, :cd_titles => cd_titles}
    end
  end

  def op_cd
    cd = Cd.find(params[:id])
    render partial: 'partial/cd.show', locals: { :cd => cd }
  end

  private

  def cd_params
    params.require(:cd).permit(:user_id,:cd_title, :cd_image, :cd_genre, musics_attributes: [:id, :cd_id, :audio, :music_title, :_destroy])
  end
end
