class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end
  
  
  #before_filter :set_current_user
  
#B  def set_current_user
#    User.current_user = current_user
 # end
  
end
