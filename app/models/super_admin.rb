class SuperAdmin < ApplicationRecord
  rolify
  resourcify
  attr_accessor :invited_by_role, :schoolname #virtual attribute
  devise :invitable, :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2, :fb_auth]
  belongs_to :school

  enum status: {
    suspended: 0,
    live: 1,
  }, _prefix: true

  def user_role
    roles.first.name.to_sym
  end

  def self.from_omniauth(access_tocken)

    puts access_tocken ,'<------------------------------------------------------------------------------------------------------------------------>' 
    super_admin = SuperAdmin.where(email: access_tocken.info.email).first

    unless super_admin
      @super_admin = SuperAdmin.create(
        email: access_tocken.info.email,
        password: Devise.friendly_token[0, 20],
        provider: access_tocken.provider,
        uid: access_tocken.uid,
        name: access_tocken.info.name
      )
      @schl = School.create(:name => 'Provider_created')
      @super_admin.school = @schl
      @super_admin.save
      
      if @super_admin.persisted?
        @super_admin.add_role(:super_admin)
      end

    end
    @super_admin
  end

end