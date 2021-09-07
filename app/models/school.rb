class School < ApplicationRecord
    belongs_to :super_admin
    validates :name , presence: true
end