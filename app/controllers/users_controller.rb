class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.new(user_param)
    if user.save
      login user
      flash[:success] = '登録が完了しました。'
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
