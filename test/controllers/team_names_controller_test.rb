require 'test_helper'

class TeamNamesControllerTest < ActionController::TestCase
  setup do
    @team_name = team_names(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:team_names)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create team_name" do
    assert_difference('TeamName.count') do
      post :create, team_name: {name: 'NewTeam On the Block'}
    end

    assert_redirected_to team_name_path(assigns(:team_name))
  end

  test "should show team_name" do
    get :show, id: @team_name
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @team_name
    assert_response :success
  end

  test "should update team_name" do
    patch :update, id: @team_name, team_name: {name: @team_name.name}
    assert_redirected_to team_name_path(assigns(:team_name))
  end

  test "should destroy team_name" do
    assert_difference('TeamName.count', -1) do
      delete :destroy, id: @team_name
    end

    assert_redirected_to team_names_path
  end
end
