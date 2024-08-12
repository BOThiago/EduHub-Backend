class FilesController < ApplicationController
    def create
      @course = Course.find(params[:course_id])
      @file = @course.files.new(file_params)
  
      if @file.save
        render json: @file, status: :created
      else
        render json: @file.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @file = File.find(params[:id])
      @file.destroy
      head :no_content
    end
  
    private
  
    def file_params
      params.require(:file).permit(:name)
    end
end