class CreateCourseFiles < ActiveRecord::Migration[7.1]
  def change
    create_table :course_files do |t|
      t.string :name
      t.references :course, null: false, foreign_key: true
      t.timestamps
    end
  end
end
