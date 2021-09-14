class UsersController < ApplicationController
  before_action :authenticate_super_admin!
  
  def index
    @users = SuperAdmin.all()
  end
  
  def activate_or_deactivate
    @user = SuperAdmin.find(params[:id])
    if @user.status_suspended?
      @user.status = 1
      @user.save
    else
      @user.status = 0
      @user.save
    end
    redirect_to users_path
  end

  def destroy
    @user = SuperAdmin.find(params[:id])
    @user.destroy
    flash[:notice] = "User deleted"
    redirect_to(users_path)
  end

end