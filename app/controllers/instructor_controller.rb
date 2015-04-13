class InstructorController < ApplicationController
  before_action :instructor_access_required

  before_action :set_user
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_user
  before_action :set_class
  rescue_from ActiveRecord::RecordNotFound, with: :not_in_class

  def index
  end

  def group_list

  end

  private
  def set_user
    @user = User.find_by(id: session[:user_id])
  end

  def set_class
    @classes = ActiveClass.where(user_id: @user.id)
  end

  def invalid_user
    logger.error("Attempt to access invalid user #{params[:id]}")
    redirect_to(login_url, notice: 'Invalid user account')
  end

  def not_in_class
    logger.error("Attempt to access invalid user #{params[:id]}")
    redirect_to(login_url, notice: 'Invalid user account')
  end

end
