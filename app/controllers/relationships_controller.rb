class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user

  def create
    current_user.follow(@user)
    respond_to do |format|
      format.html
      format.json do
        render json: { count: @user.followers.count },
               status: :created
      end
    end
  end

  def destroy
    current_user.unfollow(@user)
    respond_to do |format|
      format.html
      format.json do
        render json: { count: @user.followers.count },
               status: :ok
      end
    end
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end
end
