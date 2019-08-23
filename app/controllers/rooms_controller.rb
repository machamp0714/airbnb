# frozen_string_literal: true

class RoomsController < ApplicationController
  before_action :set_room, except: [:index, :new, :create]
  before_action :authenticate_user, except: [:show]
  before_action :correct_user, only: [:listing, :pricing, :description, :photo_upload, :amenities, :location, :update]

  def index
    @rooms = current_user.rooms
  end

  def new
    @room = current_user.rooms.build
  end

  def create
    @room = current_user.rooms.build(room_params)
    if @room.save
      redirect_to listing_room_path(@room), notice: "Saved..."
    else
      flash.now[:alert] = "Something wen wrong..."
      render "new"
    end
  end

  def show
    @reservation = @room.reservations.build
  end

  def listing
  end

  def pricing
  end

  def description
  end

  def photo_upload
    @photo = @room.photos.build
    @photos = @room.photos
  end

  def amenities
  end

  def location
  end

  def update
    new_params = room_params
    new_params = room_params.merge(active: true) if is_ready_room

    if @room.update(new_params)
      flash[:notice] = "Saved..."
    else
      flash[:notice] = "Something went wrong..."
    end
    redirect_back(fallback_location: request.referrer)
  end

  def preload
    today = Time.zone.today # Date.today
    reservations = @room.reservations.where("start_date >= ? OR end_date >= ?", today, today)

    render json: reservations
  end

  def preview
    start_date = Date.parse(params[:start_date])
    end_date = Date.parse(params[:end_date])

    output = {
      conflict: is_conflict(start_date, end_date, @room)
    }

    render json: output
  end

  private
    def is_conflict(start_date, end_date, room)
      reservations = room.reservations.where("start_date > ? AND end_date < ?", start_date, end_date)
      reservations.size > 0 ? true : false
    end

    def set_room
      @room = Room.find(params[:id])
    end

    def room_params
      params.require(:room).permit(:home_type, :room_type, :accommodate, :bed_room, :bath_room, :listing_name, :summary, :address, :is_tv, :is_air, :is_heating, :is_internet, :is_kitchen, :price, :active)
    end

    def correct_user
      room = Room.find(params[:id])
      redirect_to root_path, alert: "You don't have permission." if room.user_id != current_user.id
    end

    def is_ready_room
      !@room.active && @room.price.present? && @room.listing_name.present? && @room.photos.present? && @room.address.present?
    end
end
