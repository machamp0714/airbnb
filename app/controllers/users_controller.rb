class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_param)
    if @user.save
      UserMailer.account_activation(@user).deliver_now
      flash[:notice] = 'まだ登録は完了していません。アカウントの有効化をしてください。'
      redirect_to root_path
    else
      render :new
    end
  end

  def show

  end

  def edit
    
  end

  private
    def user_param
      params.require(:user).permit(:name, :email, :password)
    end
end
