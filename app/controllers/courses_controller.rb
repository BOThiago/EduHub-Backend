class CoursesController < ApplicationController
    before_action :set_course, only: %i[show update destroy]
  
    def index
        @courses = Course.all
        render json: @courses.as_json(methods: :total_size_in_mb)
    end
  
    def show
        render json: @course.as_json(
          methods: :total_size_in_mb,
          include: {
            course_files: {
              only: [:id, :name],
              methods: [:file_url]
            }
          }
        )
    end
  
    def create
        @course = Course.new(course_params)
        if @course.save
          render json: @course.as_json(
            methods: :total_size_in_mb,
            include: {
              course_files: {
                only: [:id, :name],
                methods: [:file_url]
              }
            }
          ), status: :created
        else
          render json: @course.errors, status: :unprocessable_entity
        end
    end
  
    def update
        if @course.errors.any?
          render json: { error: @course.errors.full_messages }, status: :forbidden
        elsif @course.update(course_params)
          render json: @course.as_json(
            methods: :total_size_in_mb,
            include: {
              course_files: {
                only: [:id, :name],
                methods: [:file_url]
              }
            }
          )
        else
          render json: @course.errors, status: :unprocessable_entity
        end
    end
  
    def destroy
        if @course.errors.any?
          render json: { error: @course.errors.full_messages }, status: :forbidden
        else
          @course.destroy
          head :no_content
        end
    end

    private
  
    def set_course
        @course = Course.find(params[:id])
    end
  
    def course_params
        params.require(:course).permit(:title, :description, :end_date, course_files_attributes: [:id, :name, :file])
    end 
end