class SuperAdmin::InvitationsController < Devise::InvitationsController
  before_action :configure_permitted_parameters, only: [:update, :new, :create]

  def create
    @role = params[:super_admin][:invited_by_role].downcase!
    params[:super_admin].delete :invited_by_role
    # for crossing the validation of name field always exists
    params[:super_admin][:name] = "Default"
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
