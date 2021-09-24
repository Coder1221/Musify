class LectureContent < ApplicationRecord
    belongs_to  :lecture
    has_many_attached :pdfs ,dependent: :destroy
end
