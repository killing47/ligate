class CdsController < ApplicationController

  def create
    cd = Cd.new(cd_params)
    cd.user_id = current_user.id
    if cd.save
      flash.now[:notice] = " Successfully Save."
      redirect_to user_path(current_user.id)
    else
      redirect_to user_path(current_user.id)
      flash.now[:notice] = "ERROR! You can't do it."
    end
  end

  def update
    @cd = Cd.find(params[:id])
    if @cd.user_id != current_user.id
      redirect_to root_path#(current_user.id)
    else
      if @cd.update(cd_params)
        flash.now[:notice] = " Successfully Updated."
        redirect_to user_path(current_user.id)
      else
        flash.now[:notice] = "ERROR! You can't do it."
        redirect_to  edit_user_path(@cd.id)
      end
    end
  end

  def destroy
    cd = Cd.find(params[:id])
    cd.destroy
    flash.now[:notice] = " Successfully Delete."
    redirect_to user_path(current_user.id)
  end

  def fav
    cd = Cd.find(params[:id])
    if cd.favorited_by?(current_user)
      fav = current_user.favorites.find_by(cd_id: cd.id)
      fav.destroy
      c_user = current_user
      render partial: 'partial/favorites', locals: {:c_user => c_user}
    else
      fav = current_user.favorites.new(cd_id: cd.id)
      fav.save
      c_user = current_user
      render partial: 'partial/favorites', locals: {:c_user => c_user}
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
