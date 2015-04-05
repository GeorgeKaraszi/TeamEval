class TeamNamesController < ApplicationController
  before_action :set_team_name, only: [:show, :edit, :update, :destroy]

  # GET /team_names
  # GET /team_names.json
  def index
    @team_names = TeamName.all
  end

  # GET /team_names/1
  # GET /team_names/1.json
  def show
  end

  # GET /team_names/new
  def new
    @team_name = TeamName.new
  end

  # GET /team_names/1/edit
  def edit
  end

  # POST /team_names
  # POST /team_names.json
  def create
    @team_name = TeamName.new(team_name_params)

    respond_to do |format|
      if @team_name.save
        format.html { redirect_to @team_name, notice: 'Team name was successfully created.' }
        format.json { render :show, status: :created, location: @team_name }
      else
        format.html { render :new }
        format.json { render json: @team_name.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /team_names/1
  # PATCH/PUT /team_names/1.json
  def update
    respond_to do |format|
      if @team_name.update(team_name_params)
        format.html { redirect_to @team_name, notice: 'Team name was successfully updated.' }
        format.json { render :show, status: :ok, location: @team_name }
      else
        format.html { render :edit }
        format.json { render json: @team_name.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /team_names/1
  # DELETE /team_names/1.json
  def destroy
    @team_name.destroy
    respond_to do |format|
      format.html { redirect_to team_names_url, notice: 'Team name was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_team_name
    @team_name = TeamName.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def team_name_params
    params.require(:team_name).permit(:name)
  end
end
