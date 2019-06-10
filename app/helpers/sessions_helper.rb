module SessionsHelper
  def login(user)
    session[:user_id] = user.id
  end

  def current_user
    if session[:user_id]
      # if @current_user.nil?
      #   @current_user = User.find_by(id: sessions[:user_id])
      # else
      #   @current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  def signed_in?
    !current_user.nil?
  end

  def logout
    session.delete(:user_id)
    @current_user = nil
  end
end
