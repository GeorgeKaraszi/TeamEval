class AdminController < ApplicationController
  before_action :admin_access_required

  def index
  end
end
