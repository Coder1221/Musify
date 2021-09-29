class DashBoardController < ApplicationController
  before_action :authenticate_super_admin!

  def index; end
end
