class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && user.authenticated?(:activation, params[:id])
      user.update_attribute(:activated, true)
      user.update_attribute(:activated_at, Time.zone.now)
      login user
      flash[:success] = 'アカウントが有効化されました。'
      redirect_to root_path
    else
      flash[:danger] = 'このリクエストは無効です。'
      redirect_to root_path
    end
  end
end
