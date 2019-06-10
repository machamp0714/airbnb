class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "ログインしました。"
      redirect_to root_path
    else
      flash.now[:danger] = 'メールアドレスかパスワードのどちらかに間違いがあります。'
      render :new
    end
  end
end
