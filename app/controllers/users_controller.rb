class UsersController < ApplicationController
  before_action :authenticate_super_admin!
  
  def index
    @users = SuperAdmin.all()
  end
  
  def destroy
    @user = SuperAdmin.find(params[:id])
    @user.destroy
    flash[:notice] = "User deleted"
    redirect_to(users_path)
  end

end