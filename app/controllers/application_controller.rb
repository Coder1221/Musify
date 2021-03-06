class ApplicationController < ActionController::Base
    def current_user
        current_user ||= session[:current_user_id] && SuperAdmin.find_by_id(session[:current_user_id]) 
    end
    helper_method :current_user
end