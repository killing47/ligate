class CdsController < ApplicationController

  def create
    cd = Cd.new(cd_params)
    cd.user_id = current_user.id
    cd_a = cd.musics.map{|a| a.audio.attached?}
    if cd_a.any? {|w| w == false } || cd_a.blank?
      redirect_to user_path(current_user.id),notice: "ERROR! You can't do it."
    else
      if cd.save
        redirect_to user_path(current_user.id),notice: "Successfully Save."
      else
        redirect_to user_path(current_user.id)
      end
    end
  end

  def update
    @cd = Cd.find(params[:id])
    if @cd.user_id != current_user.id
      redirect_to root_path
    else
      if @cd.update(cd_params)
        cd_a = @cd.musics.map{|a| a.audio.attached?}
        if cd_a.any? {|w| w == false } || cd_a.blank?
          redirect_to edit_user_path(@cd.id),notice: "ERROR! You can't do it."
        else
          redirect_to user_path(current_user.id),notice: "Successfully Save."
        end
      else
        redirect_to  edit_user_path(@cd.id),notice: "ERROR! You can't do it."
      end
    end
  end

  def destroy
    cd = Cd.find(params[:id])
    cd.destroy
    flash.now[:notice] = " Successfully Delete."
    redirect_to user_path(current_user.id),notice: "Successfully Save."
  end

  def fav
    cd = Cd.find(params[:id])
    if cd.favorited_by?(current_user)
      fav = current_user.favorites.find_by(cd_id: cd.id)
      fav.destroy
      ct_user = current_user
      render partial: 'partial/favorites', locals: {:ct_user => ct_user}
    else
      fav = current_user.favorites.new(cd_id: cd.id)
      fav.save
      ct_user = current_user
      render partial: 'partial/favorites', locals: {:ct_user => ct_user}
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
