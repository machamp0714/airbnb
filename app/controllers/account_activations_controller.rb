# frozen_string_literal: true

class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && user.authenticated?(:activation, params[:id])
      user.activate
      login user
      flash[:success] = "アカウントが有効化されました。"
      redirect_to root_path
    else
      flash[:danger] = "このリクエストは無効です。"
      redirect_to root_path
    end
  end
end
