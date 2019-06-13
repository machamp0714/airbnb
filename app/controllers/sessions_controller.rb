class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      if user.activated?
        login user
        params[:remember_me] == 1 ? remember(user) : forget(user)
        flash[:success] = 'ログインしました。'
        redirect_to root_path
      else
        flash[:alert] = 'アカウントは有効ではありません。'
        redirect_to root_path
      end
    else
      flash.now[:danger] = 'メールアドレスかパスワードのどちらかに誤りがあります。'
      render :new
    end
  end

  def destroy
    logout if signed_in?
    flash[:success] = 'ログアウトしました。'
    redirect_to root_path
  end
end
