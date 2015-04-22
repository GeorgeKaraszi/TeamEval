class InstructorController < ApplicationController
  before_action :instructor_access_required

  before_action :set_user
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_user
  before_action :set_class
  rescue_from ActiveRecord::RecordNotFound, with: :not_in_class
  before_action :set_assignment, only: [:as_summery]

  def index
  end

  def group_list
  end

  def as_summery

  end

  private

  def set_assignment
    @assignment = Assignment.find(params[:id])
  end

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
