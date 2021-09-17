class School < ApplicationRecord
  validates :name, presence: true
  has_many :SuperAdmin
  has_one_attached :avatar

  # validate :blank_name
  # def blank_name
  #   if name == ""
  #     errors.add(:name, "Blank name not Allowed")
  #   end
  # end
end
