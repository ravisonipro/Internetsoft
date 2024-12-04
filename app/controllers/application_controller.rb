class ApplicationController < ActionController::Base
  before_action :authenticate_user!  # This ensures user is authenticated

  def current_user
    super 
  end

  def after_sign_in_path_for(resource)
    if resource.role == 'super_admin'
      admin_users_path 
    else
      users_dashboard_users_path
    end
  end
end
