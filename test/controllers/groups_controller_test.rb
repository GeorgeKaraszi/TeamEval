require 'test_helper'

class GroupsControllerTest < ActionController::TestCase
  setup do
    @group = groups(:group_1)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create group" do
    assert_difference('Group.count') do
      post :create, group: {active_class_id: 1,
                            team_name_id: 1,
                            user_id: 1}
    end

    assert_redirected_to group_path(assigns(:group))
  end

  test "should show group" do
    get :show, id: @group
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @group
    assert_response :success
  end

  test "should fail by trying to assign instructor to group" do
    assert_no_difference('Group.count') do
      post :create, group: {active_class_id: 1, team_name_id: 1, user_id: 3}
    end
  end

  test "should update group" do
    patch :update, id: @group, group: {active_class_id: @group.active_class_id,
                                       team_name_id: @group.team_name_id,
                                       user_id: @group.user_id}
    assert_response :success
  end

  test "should destroy group" do
    assert_difference('Group.count', -1) do
      delete :destroy, id: @group
    end

    assert_redirected_to groups_path
  end
end
