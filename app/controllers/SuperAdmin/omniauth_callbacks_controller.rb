# frozen_string_literal: true

class SuperAdmin::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  def google_oauth2
    handle_auth "Google"
  end

  def fb_auth
    handle_auth "Facebook"
  end

  def handle_auth(kind)
    @super_admin = SuperAdmin.from_omniauth(request.env["omniauth.auth"])
    if @super_admin.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", kind: kind
      sign_in_and_redirect @super_admin, event: :authentication
    else
      session["devise.auth_data"] = request.env["omniauth.auth"].except("extra") # Removing extra as it can overflow some session stores
      redirect_to new_super_admin_registration_url, alert: @super_admin.errors.full_messages.join("\n")
    end
  end
end
