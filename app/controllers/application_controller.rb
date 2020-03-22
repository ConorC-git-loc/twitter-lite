class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :set_search




protected

  def set_search
   @q=User.ransack(params[:q])
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :handle])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :handle]) 
  end
	
end
