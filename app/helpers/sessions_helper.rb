module SessionsHelper
  def login(user)
    session[:user_id] = user.id
  end

  def current_user
    if user_id = session[:user_id]
      # if @current_user.nil?
      #   @current_user = User.find_by(id: sessions[:user_id])
      # else
      #   @current_user
      @current_user ||= User.find_by(id: user_id)
    elsif user_id = cookies.signed[:user_id]
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        login user
        @current_user = user
      end
    end
  end

  def signed_in?
    !current_user.nil?
  end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def logout
    session.delete(:user_id)
    @current_user = nil
  end
end
