class Course < ApplicationRecord
  has_many :course_files, dependent: :destroy
  accepts_nested_attributes_for :course_files
  has_one_attached :course_banner

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

  def course_banner_url
    Rails.application.routes.url_helpers.rails_blob_url(course_banner, only_path: true) if course_banner.attached?
  end
end
