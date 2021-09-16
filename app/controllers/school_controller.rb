class SchoolController < ApplicationController
  before_action :authenticate_super_admin!
  load_and_authorize_resource

  def index
    @schools = School.all()
  end

  def new
    @school = School.new
  end

  def show
    @school = School.find(params[:id])
  end

  def edit
    @school = School.find(params[:id])
    puts request.inspect
  end

  def update
    @school = School.find(params[:id])
    if @school.update(update_params)
      @school.save
      flash[:notice] = "School Information Updated"
      render "edit"
    end
  end

  protected

  def update_params
    params.require(:school).permit(:name, :email, :adress, :city, :phone, :zip_code, :logo)
  end
end
