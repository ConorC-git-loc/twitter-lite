class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :update, :destroy]
  before_action :authenticate_user!
  before_action :set_search



  def new
  	@tweet = current_user.tweets.build
  end

  def index
  	@tweets = Tweet.all
    @users = User.all
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true)
  end

  def current_user?
    super || User.new
  end


  def show
    @tweet = Tweet.find(params[:id])
  end
        
  def create
    @tweet = current_user.tweets.build(tweet_params)
    @tweet.save
    flash.now[:notice] = 'Alert message!'
    redirect_to root_path
  end

  

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    redirect_to root_path
  end


private 

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end


  def tweet_params
  	params.require(:tweet).permit(:user_id, :content)
  end 



end
