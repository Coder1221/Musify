# frozen_string_literal: true
class SuperAdmin::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  # GET /resource/sign_in
  def new
    self.resource = resource_class.new(sign_in_params)
    clean_up_passwords(resource)
    yield resource if block_given?
    respond_with(resource, serialize_options(resource))
  end

  # POST /resource/sign_in
  def create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)

    if self.resource.status_suspended?
      sign_out(resource_name)
      flash[:notice] = 'Suspened Account'
      sign_out_and_redirect(current_super_admin)
    else
      # for device current user
      session[:current_user_id] = self.resource.id
      set_flash_message!(:notice, :signed_in)
      yield resource if block_given?
      respond_with resource, location: after_sign_in_path_for(resource)
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
