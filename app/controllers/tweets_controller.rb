class TweetsController < ApplicationController



  def new
  	@tweet = Tweet.new
  end

  def index
  	@tweets = Tweet.all
  end

  def show
    @tweet = Tweet.find(params[:id])
  end

  def follow
    @user = User.find(params[:id])
    @current_user.followers << @user
    redirect_to user_path(@user)
  end

  def unfollow
    @user = User.find(params[:id])
    @current_user.followed_users.find_by(user_id: 
        @user.id).destroy
    redirect_to user_path(@user)
  end

  def create
  	tweet = Tweet.new(tweet_params)
  	if tweet.save
  		redirect_to user_path(tweet.user)
  	else
  		render 'new'
  	end
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    respond_to do |format|
        format.html { redirect_to root_path notice: 'Tweet Removed' }
        format.json { head :no_content }
    end
end


  private 

  def tweet_params
  	params.require(:tweet).permit(:user_id, :content)
  end 

end
