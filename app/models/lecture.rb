class Lecture < ApplicationRecord
    belongs_to :super_admin
    has_many :lecture_contents ,dependent: :destroy
    accepts_nested_attributes_for :lecture_contents , reject_if: :all_blank , allow_destroy: true
end
