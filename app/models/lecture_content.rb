class LectureContent < ApplicationRecord
    belongs_to  :lecture
    has_many_attached :pdfs
end
