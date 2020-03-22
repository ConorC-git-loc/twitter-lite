class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_search

  def show
    @user = User.find(params[:id])
  end

  def search_index
  	@q = User.ransack(params[:q])
  	@users = @q.result.paginate(page: params[:page])
  end
end