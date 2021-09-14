class SuperAdmin < ApplicationRecord
  rolify
  resourcify
  attr_accessor :invited_by_role, :schoolname #virtual attribute
  devise :invitable, :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_one :school

  def user_role
    roles.first.name
  end
end
