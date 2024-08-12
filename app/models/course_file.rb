class CourseFile < ApplicationRecord
  belongs_to :course
  has_one_attached :file

  def file_url
    Rails.application.routes.url_helpers.rails_blob_url(file, only_path: true) if file.attached?
  end
end