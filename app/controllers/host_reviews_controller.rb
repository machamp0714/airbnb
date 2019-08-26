class HostReviewsController < ApplicationController

  def create
    @reservation = Reservation.find_by(
                    id: host_review_params[:reservation_id],
                    room_id: host_review_params[:room_id],
                    user_id: host_review_params[:guest_id]
    )
    if !@reservation.nil?
      @has_reviewed = HostReview.find_by(
                        reservation_id: @reservation.id,
                        guest_id: host_review_params[:guest_id]
                      )
      if @has_reviewed.nil?
        @host_review = current_user.host_reviews.create(host_review_params)
        flash[:success] = "Review created..."
      else
        flash[:notice] = "You already reviewed this Reservation."
      end
    else
      flash[:alert] = "Not Found this reservation."
    end
    redirect_back fallback_location: request.referrer
  end

  private

    def host_review_params
      params.require(:host_review).permit(:comment, :star, :room_id, :reservation_id, :guest_id)
    end
end
