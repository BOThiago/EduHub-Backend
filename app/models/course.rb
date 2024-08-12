class Course < ApplicationRecord
  has_many :course_files, dependent: :destroy
  accepts_nested_attributes_for :course_files

  def total_size_in_mb
    total_size_in_bytes = course_files.sum do |course_file|
      if course_file.file.attached?
        course_file.file.byte_size
      else
        0
      end
    end
    (total_size_in_bytes.to_f / 1.megabyte).round(2)
  end
end
