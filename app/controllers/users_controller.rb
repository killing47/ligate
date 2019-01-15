class UsersController < ApplicationController

  def qr_code
    @qr = RQRCode::QRCode.new(url_for :controller => 'users', :action => 'show', :only_path => false, :size => 8, :level => :h ).as_svg.html_safe
  end

  def show
    @user = User.find(params[:id])
    qr_code
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "sample",   # PDF名
        template: "partial/_qr_code.html.erb" # viewを対象にする
      end
    end
  end

  def admin
  end

  def update
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:nick_name,:image_id,:introduction)
  end

end
