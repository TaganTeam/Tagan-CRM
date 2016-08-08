class Access::SessionsController < Devise::SessionsController
  skip_before_action :auth_user!

  layout 'auth'
  skip_filter *_process_action_callbacks.map(&:filter)
  prepend_before_filter :allow_params_authentication!, only: :create
  prepend_before_filter only: [ :create, :destroy ] { request.env["devise.skip_timeout"] = true }

  def create
    resource = warden.authenticate!(auth_options)
    if request.xhr?
      if sign_in(resource_name, resource)
        render json: (current_user.as_api_response(:default_token)).as_json.merge(csrfParam: request_forgery_protection_token, csrfToken: form_authenticity_token)
      else
        render json: false, status: 403
      end
    else
      set_flash_message(:notice, :signed_in) if is_flashing_format?
      sign_in(resource_name, resource)
      yield resource if block_given?
      sign_in_attributes = {
          current_sign_in_ip: request.env['REMOTE_ADDR'],
          current_sign_in_at: DateTime.now,
          last_sign_in_at: DateTime.now,
          last_sign_in_ip: request.env['REMOTE_ADDR'],
          sign_in_count:   (resource.sign_in_count.to_i + 1)
      }

        resource.update_columns(sign_in_attributes)
      if current_user.admin
        redirect_to "/admin"
      else
        respond_with resource, location: signed_in_root_path(resource)
      end
        # resource.admin?redirect_to admin_path: redirect_to root_path
    end
  end

  def new
    redirect_to root_path
  end
end
