class Lecture < ApplicationRecord
    belongs_to :super_admin
    has_many :lecture_contents ,depenedent: :destroy
    accept_nested_attributes_for :lecture_contents ,reject_if: :all_blank , allow_destroy: ture
end
