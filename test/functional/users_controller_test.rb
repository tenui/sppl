require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  context "When signed in as Admin" do
    setup do
      sign_in_as_admin
    end

    should "Be able to see all Users" do
      get :index
      assert_response :success
      assert_not_nil assigns(:users)
    end

    should "should get new" do
      get :new
      assert_response :success
    end

    should "be able to Create a User" do
      assert_difference('User.count') do
        post :create, :user => {:username => "Tester", :password => "testy", :password_confirmation => "testy"}
      end

      assert_redirected_to user_path(assigns(:user))
    end

    should "should show user" do
      get :show, :id => @user.to_param
      assert_response :success
    end

    should "should get edit" do
      get :edit, :id => @user.to_param
      assert_response :success
    end

    should "should update user" do
      put :update, :id => @user.to_param, :user => @user.attributes
      assert_redirected_to user_path(assigns(:user))
    end

    should "should destroy user" do
      assert_difference('User.count', -1) do
        delete :destroy, :id => @user.to_param
      end

      assert_redirected_to users_path
    end
  end

  context "When signed in as a Player" do
    setup do
      sign_in_as_player
    end

    should "NOT be able to see all Users" do
      get :index
      assert_response :redirect
      assert_nil assigns(:users)
    end
  end

end
