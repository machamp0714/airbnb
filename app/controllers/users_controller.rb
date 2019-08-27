# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:notice] = "まだ登録は完了していません。アカウントの有効化をしてください。"
      redirect_to root_path
    else
      render "new"
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    @rooms = @user.rooms

    @guest_reviews = Review.where(type: "GuestReview", host_id: @user.id)
    @host_reviews = Review.where(type: "HostReview", host_id: @user.id)
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update(update_user_params)
      flash[:success] = "Success!!"
      redirect_to edit_user_path(@user)
    else
      render "edit"
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password)
    end

    def update_user_params
      params.require(:user).permit(:name, :phone_number, :description, :email, :password)
    end
end
