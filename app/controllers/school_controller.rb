class SchoolController < ApplicationController
  before_action :authenticate_super_admin!
  load_and_authorize_resource

  def index
    @users = @schools.first.SuperAdmin
    @count_hash = @users.each_with_object(Hash.new(0)) do |user ,hash|
      hash[user.user_role] += 1
    end
  end

  def show
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
