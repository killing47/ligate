class HomesController < ApplicationController

  def top
    if current_user
      @user  = current_user
    end
    @users = User.all
    @cds   = Cd.all
  end

end
