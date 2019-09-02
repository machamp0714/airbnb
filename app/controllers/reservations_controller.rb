# frozen_string_literal: true

class ReservationsController < ApplicationController
  before_action :authenticate_user

  def create
    room = Room.find(params[:room_id])

    if current_user == room.user
      flash[:alert] = "You cannot book your own property!"
      redirect_to room
    elsif current_user.stripe_id.blank?
      flash[:alert] = "Please Update your payment method."
      redirect_to payment_method_path
    else
      start_date = Date.parse(reservation_params[:start_date])
      end_date = Date.parse(reservation_params[:end_date])
      days = (end_date - start_date).to_i + 1

      @reservation = current_user.reservations.build(reservation_params)
      @reservation.room = room
      @reservation.price = room.price
      @reservation.total = room.price * days

      if @reservation.Waiting!
        if room.Request?
          flash[:notice] = "Request sent successfully!"
        else
          charge(room, @reservation)
          flash[:notice] = "Reservation created successfully!"
        end
      else
        flash[:alert] = "Cannot make a reservation."
      end
      redirect_to room
    end
  end

  def your_trips
    @trips = current_user.reservations.order(start_date: :asc)
  end

  def your_reservations
    @rooms = current_user.rooms
  end

  def approve
    @reservation = Reservation.find(params[:id])
    charge(@reservation.room, @reservation)
    redirect_to your_reservations_path
  end

  def dicline
    @reservation = Reservation.find(params[:id])
    @reservation.Dicline!
    redirect_to your_reservations_path
  end

  private
    def send_sms(room, reservation)
      @client = Twilio::REST::Client.new
      @client.api.account.messages.create(
        from: ENV["TWILIO_FROM"],
        to: room.user.phone_number,
        body: "#{reservation.user.name} booked your '#{room.listing_name}'"
      )
    end

    def reservation_params
      params.require(:reservation).permit(:start_date, :end_date)
    end

    def check_user
      room = current_user.rooms.find_by(id: params[:room_id])
      redirect_to room, alert: "Noooooo" if room
    end

    def charge(room, reservation)
      if reservation.user.stripe_id.present?
        customer = Stripe::Customer.retrieve(reservation.user.stripe_id)
        charge = Stripe::Charge.create(
          customer: customer.id,
          amount: reservation.total * 100,
          description: room.listing_name,
          currency: "usd",
        )
        if charge
          reservation.Approved!
          ReservationMailer.send_email_to_guest(reservation.user, room).deliver_later if reservation.user.setting.enable_email?
          send_sms(room, reservation) if room.user.setting.enable_sms?
          flash[:notice] = "Reservation created successfully!"
        else
          reservation.Decline!
          flash[:alert] = "Cannot charge with this payment method."
        end
      end
    rescue Stripe::CardError => e
      reservation.Decline!
      flash[:alert] = e.message
    end
end
