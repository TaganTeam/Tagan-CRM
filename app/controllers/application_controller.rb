class ApplicationController < ActionController::Base

  ActiveSupport::Deprecation.silenced = true
  protect_from_forgery with: :exception
  # before_filter :configure_permitted_parameters, if: :devise_controller?
  before_action :auth_user!

  # include DeviseOverrides

  def index
  end

  def show
  end

  private

  def auth_user!
    exclusion_redirect = [login_path].include?(request.fullpath)
    if current_user
      current_user.validate_request!(request,params)
      current_user_valid = !current_user.errors.present?
      if exclusion_redirect
        redirect_to root_path if current_user_valid
      else
        warden.logout unless current_user_valid
      end
    else
      redirect_to login_path if !exclusion_redirect
    end
  end

  def authenticate_admin_user!
    exclusion_redirect = [admin_root_path].include?(request.fullpath)
    if exclusion_redirect
      redirect_to root_path unless current_user.admin
    end
  end

  def current_admin_user
    if user_signed_in? && !current_user.admin
      redirect_to root_path
    end
    current_user
  end
end


