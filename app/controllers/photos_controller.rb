class PhotosController < ApplicationController
  def create
    room = Room.find(params[:room_id])
    if params[:photo][:image]
      room.photos.create(image: params[:photo][:image])
    end

    @photos = room.photos
    redirect_back fallback_location: request.referer, notice: 'Saved'
  end
end
