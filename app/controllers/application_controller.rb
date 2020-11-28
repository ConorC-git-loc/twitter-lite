class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :set_search

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || tweets_path
  end

  protected

  def set_search
    @search = User.ransack(params[:q])
    @q = Tweet.ransack(params[:q])
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[username handle about])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[username avatar handle about])
  end
end
