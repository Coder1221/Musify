class School < ApplicationRecord
  validates :name, presence: true
  has_many :SuperAdmin
  has_one_attached :avatar
  # validate :blank_name

  def blank_name
    unless phone == "" or phone == nil
      unless phone.match('^0\d{10}')
        puts 'error should be added'
        errors.add(:phone , "Regex not Matched")
      end
    end
  end

end
