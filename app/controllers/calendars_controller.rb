class CalendarsController < ApplicationController
  before_action :authenticate_user

  def host
    @rooms = current_user.rooms

    params[:start_date] ||= Date.current.to_s
    params[:room_id] ||= @rooms[0] ? @rooms[0].id : nil

    if params[:q].present?
      params[:start_date] = params[:q][:start_date]
      params[:room_id] = params[:q][:room_id]
    end

    @search = Reservation.ransack(params[:q])

    if params[:room_id]
      @room = Room.find(params[:room_id])
      start_date = Date.parse(params[:start_date])

      first_of_month = (start_date - 1.month).beginning_of_month
      end_of_month = (start_date + 1.month).end_of_month

      @events = @room.reservations.joins(:user)
                      .select("reservations.*, users.name, users.email")
                      .where("(start_date BETWEEN ? AND ?) AND status <> ?", first_of_month, end_of_month, 2)
    else
      @room = nil
      @events = []
    end
  end
end