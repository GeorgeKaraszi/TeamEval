class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :set_instructor, only: [:upload_student]

  # GET /users
  # GET /users.json
  def index
    @users = User.order(:real_name)
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  def new_upload_student
    if params[:file].nil?
    else
      create_by_file(params[:file], params[:class][:active_class_id])
      redirect_to instructor_portal_path
    end
  end

  def upload_student

  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: "User #{@user.username}(#{@user.real_name})was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User #{@user.username}(#{@user.real_name}) was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def create_by_file(classfile, active_class)
    return nil if classfile.blank? or not
    (classfile.respond_to?('original_filename') and classfile.respond_to?('read'))

    upload_file_name = classfile.original_filename
    contents = classfile.read

    contents.each_line.each do |line|
      userInfo = line.split(',')

      User.create!(username: userInfo[0],
                   real_name: userInfo[1],
                   password: 'pass123',
                   password_confirmation: 'pass123',
                   id_type: 1)
      Group.create!(user: User.find_by_username(userInfo[0]),
                    team_name_id: userInfo[2].strip,
                    active_class_id: active_class)

    end
    return upload_file_name
  end

  def set_instructor
    @user = User.find_by(id: session[:user_id])
  end

  # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation, :real_name, :id_type)
    end
end
