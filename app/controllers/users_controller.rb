class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_search
 



  def search_index
  	@q = User.ransack(params[:q])
  	@users = @q.result
  end

end


