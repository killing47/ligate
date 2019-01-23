class UsersController < ApplicationController
  protect_from_forgery except: :update
  protect_from_forgery except: :image_update

  def qr_code #QRコード作成メソッド
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
    @users  = User.page(params[:page]).reverse_order
     if params[:content] == ""
       @users = User.page(params[:page]).reverse_order
     else
       users = User.where('name LIKE ?', "%#{params[:content]}%").or(User.where('nick_name LIKE ?', "%#{params[:content]}%"))
       if users == []
         flash.now[:danger] = "ERROR!検索結果はありません。"
       end
       users_id = []
       users.each do |f|
         users_id.push(User.find(f.id))
       end
       @users = Kaminari.paginate_array(users_id).page(params[:page])
     end
  end

  def edit
    @cd = Cd.find(params[:id])
  end

  def update #更新アクション
    @user = User.find(params[:id])
    if@user.update(user_params)
      flash[:success] = "ユーザー情報を更新しました。"
      if @user.status == "gest"
        redirect_to  root_path(current_user)
      else
        redirect_to  user_path(current_user)
      end
    else
      flash.now[:danger] = "ユーザー情報の更新に失敗しました。記入内容を確認してください。"
      if @user.status == "gest"
        redirect_to  root_path(current_user)
      else
        redirect_to  user_path(current_user)
      end
    end
  end

  def st_up
    if current_user.status == "gest"
      user = User.find(current_user.id)
      user.status = "contribution"
      user.save
      redirect_to user_path(current_user)
    end
  end

  def destroy #削除アクション
  end

  private #ストロングパラメータ

  def user_params
    params.require(:user).permit(:nick_name,:image,:introduction)
  end

end
