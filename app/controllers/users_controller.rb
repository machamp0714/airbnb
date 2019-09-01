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
    @host_reviews = Review.where(type: "HostReview", guest_id: @user.id)
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

  def update_phone_number
    current_user.update(update_user_params)
    current_user.generate_pin
    current_user.send_pin

    redirect_to edit_user_path(current_user), notice: "Saved..."
  rescue StandardError => e
    redirect_to edit_user_path(current_user), alert: "#{e.message}"
  end

  def verify_phone_number
    current_user.verify_pin(params[:user][:pin])

    if current_user.phone_verified
      flash[:notice] = "Your phone number is verified."
    else
      flash[:alert] = "Cannot verify your phone number."
    end
    redirect_to edit_user_path(current_user)
  rescue StandardError => e
    redirect_to edit_user_path(current_user), alert: "#{e.message}"
  end

  def payment

  end

  def add_card
    if current_user.stripe_id.blank?
      customer = Stripe::Customer.create(
        email: current_user.email
      )
      current_user.stripe_id = customer.id
      current_user.save
    else
      customer = Stripe::Customer.retrieve(current_user.stripe_id)
    end

    month, year = params[:expiry].split(/ \/ /)
    new_token = Stripe::Token.create(
      card: {
        number: params[:number],
        exp_month: month,
        exp_year: year,
        cvc: params[:cvv]
      }
    )
    customer.sources.create(source: new_token.id)

    flash[:notice] = "Your card saved."
    redirect_to payment_method_path
  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to payment_method_path
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password)
    end

    def update_user_params
      params.require(:user).permit(:name, :phone_number, :description, :email, :password, :phone_number, :pin)
    end
end
