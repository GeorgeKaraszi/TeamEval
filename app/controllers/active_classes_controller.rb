class ActiveClassesController < ApplicationController
  before_action :set_active_class, only: [:show, :edit, :update, :destroy]

  # GET /active_classes
  # GET /active_classes.json
  def index
    @active_classes = ActiveClass.order(:user_id, :number)
  end

  # GET /active_classes/1
  # GET /active_classes/1.json
  def show
  end

  # GET /active_classes/new
  def new
    @active_class = ActiveClass.new
  end

  # GET /active_classes/1/edit
  def edit
  end

  # POST /active_classes
  # POST /active_classes.json
  def create
    @active_class = ActiveClass.new(active_class_params)

    respond_to do |format|
      if @active_class.save
        format.html { redirect_to instructor_portal_path, notice: 'Active class was successfully created.' }
        format.json { render :show, status: :created, location: @active_class }
      else
        format.html { render :new }
        format.json { render json: @active_class.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /active_classes/1
  # PATCH/PUT /active_classes/1.json
  def update
    respond_to do |format|
      if @active_class.update(active_class_params)
        format.html { redirect_to @active_class, notice: 'Active class was successfully updated.' }
        format.json { render :show, status: :ok, location: @active_class }
      else
        format.html { render :edit }
        format.json { render json: @active_class.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /active_classes/1
  # DELETE /active_classes/1.json
  def destroy
    @active_class.destroy
    respond_to do |format|
      format.html { redirect_to active_classes_url, notice: 'Active class was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_active_class
      @active_class = ActiveClass.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def active_class_params
      params.require(:active_class).permit(:name, :number, :user_id)
    end
end
