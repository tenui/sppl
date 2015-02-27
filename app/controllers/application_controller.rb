class ApplicationController < ActionController::Base

  protect_from_forgery
  helper_method :changes_allowed?, :current_user

  config.relative_url_root = ""

  private

  def changes_allowed?
    return current_user && current_user.username == "admin"
  end

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session ||= UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  def require_admin
    unless current_user && current_user.username == "admin"
      flash[:error] = "You must be an administrator to access that capability"
      redirect_to :root
      return false
    end
  end

  def require_user
    unless current_user
      flash[:error] = "You must be logged in to access this page"
      redirect_to :root
      return false
    end
  end

end
