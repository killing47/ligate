class UsersController < ApplicationController
  protect_from_forgery except: :update
  protect_from_forgery except: :image_update

  def qr_code #QRコード作成メソッド
    #QRコード作成
    @qr = RQRCode::QRCode.new(url_for :controller => 'users', :action => 'show', :only_path => false, :size => 8, :level => :h ).as_svg.html_safe
  end

  def show #ユーザ詳細画面
    @user = User.find(params[:id])
    qr_code
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "sample",   # PDF名
        template: "partial/_qr_code.html.erb" # viewを対象にする
      end
    end

    @cds = Cd.all
    @cd  = Cd.new

  end

  def admin #管理者画面
    @users = User.all
  end

  def update #更新アクション

    if current_user.status == "gest"
      user = User.find(params[:id])
      user.status = "contribution"
      user.save
      redirect_to user_path(current_user)

    end

    if params[:user]
      @user = User.find(params[:id])
      if@user.update(user_params)
        render :json => post
        flash[:success] = "ユーザー情報を更新しました。"
      else
        render :template => "partial/profile"
        flash.now[:danger] = "ユーザー情報の更新に失敗しました。記入内容を確認してください。"
      end
    end

  end

  def image_update
    @user = current_user
    @user.update(user_params)
    head :ok

    #render :nothing
    #render :partial => "profile", locals: {user: @user}
  end

  def nick_name_update
  end


  def destroy #削除アクション
  end

  private #ストロングパラメータ

  def user_params
    params.require(:user).permit(:nick_name,:image,:introduction)
  end

end
