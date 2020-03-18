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
