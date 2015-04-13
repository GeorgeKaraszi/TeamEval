require 'test_helper'

class SessionsControllerTest < ActionController::TestCase

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should login as student' do
    jimmy = users(:Student)
    post :create, username: jimmy.username, password: 'secret'
    assert_redirected_to student_portal_url
    assert_equal jimmy.id, session[:user_id]
  end

  test 'should login as instructor' do
    drTree = users(:instructor)
    post :create, username: drTree.username, password: 'secret'
    assert_redirected_to instructor_portal_url
    assert_equal drTree.id, session[:user_id]
  end

  test 'should login as admin' do
    superAdmin = users(:admin)
    post :create, username: superAdmin.username, password: 'secret'
    assert_redirected_to admin_portal
    assert_equal drTree.id, session[:user_id]
  end

  test 'should fail logging in' do
    jimmy = users(:Student)
    post :create, username: jimmy.username, password: 'wrong'
    assert_redirected_to login_url
  end

  test 'should get create' do
    get :create
    assert_response :success
  end

  test 'should get destroy' do
    get :destroy
    assert_response :success
  end

end
