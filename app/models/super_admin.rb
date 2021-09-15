class SuperAdmin < ApplicationRecord
  rolify
  resourcify
  attr_accessor :invited_by_role, :schoolname #virtual attribute
  devise :invitable, :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_one :school

  enum status: {
    suspended: 0,
    live: 1,
  }, _prefix: true

  def user_role
    roles.first.name.to_sym
  end

end
