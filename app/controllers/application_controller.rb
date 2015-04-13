class ApplicationController < ActionController::Base

  before_action :set_user
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  def set_user
    @user = User.find_by(id: session[:user_id])
  end

  protected

  def authorize
    unless User.find_by(id: session[:user_id])
      redirect_to login_url, notice: 'Please log in'
    end
  end

  def admin_access_required
    user = User.find_by_id(session[:user_id])

    if user.nil?
      redirect_to login_url, notice: 'Please login'
    else
      redirect_to login_url, notice: 'Please login' unless user.isAdmin
    end
  end

  def instructor_access_required
    user = User.find_by_id(session[:user_id])


    if user.nil?
      redirect_to login_url, notice: 'Please login'
    else
      redirect_to login_url, notice: 'Please login' unless user.isInstructor
    end
  end
end
