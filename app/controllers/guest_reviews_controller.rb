class GuestReviewsController < ApplicationController

  def create
    @reservation = Reservation.find_by(
                    id: guest_review_params[:reservation_id],
                    room_id: guest_review_params[:room_id]
    )
    if !@reservation.nil && @reservation.room.user.id == guest_review_params[:host_id]
      @has_reviewed = GuestReview.find_by(
                        reservation_id: @reservation.id,
                        host_id: guest_review_params[:host_id]
                      )
      if @has_reviewed.nil?
        @guest_review = current_user.guest_reviews.create(guest_review_params)
        flash[:success] = "Revire created..."
      else
        flash[:notice] = "You already reviewed this Reservation."
      end
    else
      flash[:alert] = "Not Found this reservation."
    end
    redirect_back fallback_location: request.referrer
  end

  private

    def guest_review_params
      params.require(:guest_review).permit(:comment, :star, :room_id, :reservation_id, :host_id)
    end
end
