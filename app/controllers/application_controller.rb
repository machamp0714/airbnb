class ApplicationController < ActionController::Base
  include SessionsHelper

  private
    def authenticate_user
      redirect_to root_path, alert: 'You need to sign in.' unless signed_in?
    end
end
