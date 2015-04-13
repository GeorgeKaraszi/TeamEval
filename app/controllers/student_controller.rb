class StudentController < ApplicationController
  before_action :authorize

  before_action :set_user
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_user
  before_action :set_groups
  rescue_from ActiveRecord::RecordNotFound, with: :not_in_group

  def index
  end

  private

  def set_user
    @user = User.find_by(id: session[:user_id])
  end

  def set_groups
    @groups = Group.where(user_id: @user.id)
  end

  def invalid_user
    logger.error("Attempt to access invalid user #{params[:id]}")
    redirect_to(login_url, notice: 'Invalid user account')
  end

  def not_in_group
    logger.error("Attempt to access invalid user #{params[:id]}")
    redirect_to(login_url, notice: 'Invalid user account')
  end

  def not_in_class
    logger.error("Attempt to access invalid user #{params[:id]}")
    redirect_to(login_url, notice: 'Invalid user account')
  end
end
