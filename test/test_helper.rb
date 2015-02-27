ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'authlogic/test_case'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionController::TestCase
  setup :activate_authlogic

#  def current_user
#    @user
#  end
#
  def current_user_session
    @current_user_session ||= UserSession.find
  end

  def sign_in_as_admin
    @user = Factory(:admin)
    UserSession.create(@user)
  end

  def sign_in_as_player
    @user = Factory(:user)
    UserSession.create(@user)
  end

  def sign_out_user
    current_user_session.destroy
  end

end

