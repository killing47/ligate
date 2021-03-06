class ApplicationController < ActionController::Base

 helper_method :current_user, :signed_in?

 def current_user
   User.find(session[:user_id]) if session[:user_id]
 end

 def signed_in?
    current_user
 end

 def oauth_failure
    flash[:notice] = "Canceled."
    redirect_to "/"
 end

end
