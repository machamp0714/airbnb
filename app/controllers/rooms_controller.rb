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
      redirect_to listing_room_path(@room), notice: 'Saved...'
    else
      flash.now[:alert] = 'Something wen wrong...'
      render :new
    end
  end

  def show
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
      flash[:notice] = 'Saved...'
    else
      flash[:notice] = 'Something went wrong...'
    end
    redirect_back(fallback_location: request.referer)
  end

  private

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
      !@room.active && !@room.price.blank? && !@room.listing_name.blank? && !@room.photos.blank? && !@room.address.blank?
    end
end
