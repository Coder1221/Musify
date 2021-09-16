class School < ApplicationRecord
  validates :name, presence: true
  has_many :SuperAdmin

  # validate :blank_name
  # def blank_name
  #   if name == ""
  #     errors.add(:name, "Blank name not Allowed")
  #   end
  # end
end
