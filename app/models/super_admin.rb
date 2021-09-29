class SuperAdmin < ApplicationRecord
  rolify
  resourcify
  attr_accessor :invited_by_role, :schoolname #virtual attribute
  devise :invitable, :database_authenticatable, :registerable, :recoverable, 
          :rememberable, :validatable, :omniauthable,
           omniauth_providers: [:google_oauth2, :facebook]
  belongs_to :school
  has_many :lectures , dependent: :destroy 

  enum status: {
    suspended: 0,
    live: 1,
  }, _prefix: true
  
  def to_s
    email
  end

  after_create do
    customer = Stripe::Customer.create(email: self.email)
    update(stripe_customer_id: customer.id)
  end


  def user_role
    roles.first.name.to_sym
  end

  def self.from_omniauth(access_tocken)
    # puts '<------------------------------------------------------------------------------------------------------------------------>' 
    # puts access_tocken 
    # puts '<------------------------------------------------------------------------------------------------------------------------>' 
    if access_tocken.provider == 'facebook'
      @super_admin = SuperAdmin.where(uid: access_tocken.uid).first
      unless @super_admin
        @temp_email = access_tocken.info.name.gsub(' ','_') + access_tocken.uid.to_s + '@gmail.com'
        @super_admin = SuperAdmin.create(
          email: @temp_email,
          password: Devise.friendly_token[0,20],
          provider: access_tocken.provider,
          uid: access_tocken.uid,
          name: access_tocken.info.name
        )
        @school_name = access_tocken.info.name.to_s + "'s School"
        @schl = School.create(:name => @school_name)
        @super_admin.school = @schl
        @super_admin.save
        if @super_admin.persisted?
          @super_admin.add_role(:super_admin)
        end
      end
    else
      @super_admin = SuperAdmin.where(email: access_tocken.info.email).first
      unless @super_admin
        @super_admin = SuperAdmin.create(
          email: access_tocken.info.email,
          password: Devise.friendly_token[0, 20],
          provider: access_tocken.provider,
          uid: access_tocken.uid,
          name: access_tocken.info.name
        )
        @school_name = access_tocken.info.name.to_s + "'s School"
        @schl = School.create(:name => @school_name)
        @super_admin.school = @schl
        @super_admin.save
        
        if @super_admin.persisted?
          @super_admin.add_role(:super_admin)
        end

      end
    end
    @super_admin
  end
end