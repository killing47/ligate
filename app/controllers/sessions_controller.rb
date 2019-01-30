class SessionsController < ApplicationController

  def create
    user = User.from_omniauth(request.env["omniauth.auth"])
    if user.status != "unsubscribe"
      if user.save
        session[:user_id] = user.id
        redirect_to root_path
      else
        redirect_to root_path,notice: "ERROR! You can't do it."
      end
    else
      redirect_to root_path,notice: "ERROR! You can't do it."
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path,notice: "Good Bye"
  end

end
