class RelationshipsController < ApplicationController



def create
  @followed = User.find(params[:id])
  current_user.follow!(@followed)
  respond_to do |format|
    format.js { @user = @followed}
  end
end


end