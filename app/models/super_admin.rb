class SuperAdmin < ApplicationRecord
  rolify
  attr_accessor :invited_by_role , :schoolname #virtual attribute
  has_one :school
  devise :invitable, :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  def user_role
    roles.first.name
  end

end