class TweetsController < ApplicationController


  def new
  	@tweet = Tweet.new
  end

  def index
  	@tweets = Tweet.all
  end

  def create
  	tweet = Tweet.new(tweet_params)
  	if tweet.save
  		redirect_to user_path(tweet.user)
  	else
  		render 'new'
  	end
  end


  private 

  def tweet_params
  	params.require(:tweet).permit(:user_id, :content)
  end 

end
