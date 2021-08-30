class SuperAdmin < ApplicationRecord
  rolify
  attr_accessor :invited_by_role #virtual attribute
  devise :invitable, :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  # validations in model
  validates :name , presence: true
  validates :schoolname , presence: true

  def user_role
    roles.first.name
  end

end