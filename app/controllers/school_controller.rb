class SchoolController < ApplicationController
    before_action :authenticate_super_admin!

    def index
        @schools = School.all()
    end
    
    def new
        @school  = School.new
    end

    def show
        @school = School.find(params[:id])
    end
    
    def edit
        @school = School.find(params[:id])
    end

    def update
        @school = School.find(params[:id])
        if @school.update(update_params)
            @school.save
            flash[:notice] = "School Information Updated"
            render 'edit'
        end
    end

    protected
    
    def update_params
        params.require(:school).permit(:name , :email , :adresss ,:city  , :phone , :zip_code ,:logo)
    end
end