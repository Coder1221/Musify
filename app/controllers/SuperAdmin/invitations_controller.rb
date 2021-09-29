class SuperAdmin::InvitationsController < Devise::InvitationsController
  before_action :configure_permitted_parameters, only: [:update, :new, :create]

  def create
    @role = params[:super_admin][:invited_by_role].downcase!
    params[:super_admin].delete :invited_by_role

    # for crossing the validation of name field always exists
    params[:super_admin][:name] = 'Default'
    self.resource = invite_resource

    self.resource.add_role(@role)
    School.find_by_id(current_inviter.school_id).SuperAdmin << self.resource

    resource_invited = resource.errors.empty?
    yield resource if block_given?

    if resource_invited
      if is_flashing_format? && self.resource.invitation_sent_at
        set_flash_message :notice, :send_instructions, email: self.resource.email
      end

      if self.method(:after_invite_path_for).arity == 1
        respond_with resource, location: after_invite_path_for(current_inviter)
      else
        respond_with resource, location: after_invite_path_for(current_inviter, resource)
      end
    else
      respond_with_navigational(resource) { render :new }
    end
  end

  def edit
    super
  end

  def update
    raw_invitation_token = update_resource_params[:invitation_token]
    self.resource = accept_resource
    invitation_accepted = resource.errors.empty?

    # for current user in application
    session[:current_user_id] = self.resource.id # my line
    yield resource if block_given?

    if invitation_accepted
      if resource.class.allow_insecure_sign_in_after_accept
        flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
        set_flash_message :notice, flash_message if is_flashing_format?
        resource.after_database_authentication
        sign_in(resource_name, resource)
        respond_with resource, location: after_accept_path_for(resource)
      else
        set_flash_message :notice, :updated_not_active if is_flashing_format?
        respond_with resource, location: new_session_path(resource_name)
      end
    else
      resource.invitation_token = raw_invitation_token
      respond_with_navigational(resource) { render :edit }
    end
  end

  protected

  def invite_params
    devise_parameter_sanitizer.sanitize(:invite)

    # this for data base mass params without below line (invite_params) wiil not work
    params.require(:super_admin).permit(:email, :schoolname, :name)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:invite_key_fields, keys: [:email])

    # this for permit :name params after submit field
    devise_parameter_sanitizer.permit(:accept_invitation, keys: [:name])
  end
end
