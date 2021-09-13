class School < ApplicationRecord
  validates :name, presence: true
  has_many :SuperAdmin
end
