class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def restrict_access
    redirect_to new_session_path, alert: "You must log in." unless current_user
  end

  def authorized_admin
    redirect_to '/', alert: "You don't have the access." unless current_user && current_user.admin
  end

  helper_method :current_user
end