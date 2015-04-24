class SubmissionsController < ApplicationController
  before_action :authorize

  before_action :set_user
  before_action :set_assignment, only: [:new]
  before_action :set_submission, only: [:show, :edit, :update, :destroy]

  # GET /submissions
  # GET /submissions.json
  def index
    @submissions = Submission.all
    @users = User.all
  end

  # GET /submissions/1/sub_assignment
  def sub_assignment
    @submission = Submission.new(submission_params)
  end

  def create_submission

  end

  # GET /submissions/1
  # GET /submissions/1.json
  def show
  end

  # GET /submissions/new
  def new
    @submission = Submission.new
    @submission.user = User.find_by(id: session[:user_id])
  end

  # GET /submissions/1/edit
  def edit
  end

  # POST /submissions
  # POST /submissions.json
  def create
    @submission = Submission.new(submission_params)
    @assignment = Assignment.find(@submission.assignment_id)
    @user = User.find(@submission.user_id)

    respond_to do |format|
      if @submission.save
        format.html { redirect_to student_portal_path, notice: 'Submission was successfully created.' }
        format.json { render :index, status: :created, location: student_portal_path }
      else
        format.html { render :new }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /submissions/1
  # PATCH/PUT /submissions/1.json
  def update
    respond_to do |format|
      if @submission.update(submission_params)
        format.html { redirect_to student_portal_path, notice: 'Submission was successfully updated.' }
        format.json { render :show, status: :ok, location: @submission }
      else
        format.html { render :edit }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /submissions/1
  # DELETE /submissions/1.json
  def destroy
    @submission.destroy
    respond_to do |format|
      format.html { redirect_to submissions_url, notice: 'Submission was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_user
    @user = User.find_by(id: session[:user_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_submission
    @submission = Submission.find(params[:id])
  end

  def set_assignment
    @assignment = Assignment.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def submission_params
    params.require(:submission).permit(:active_class_id, :group_id, :team_name_id, :user_id, :assignment_id,
                                       :target_user_id, :group_url, :answer1, :answer2, :answer3, :answer4, :comment)
  end
end
