class TweetsController < ApplicationController
  
  before_action :set_tweet, only: [:show, :update, :destroy]
  before_action :authenticate_user!
  before_action :set_search



  def new
  	@tweet = current_user.tweets.build
  end

  def index
  	@tweets = Tweet.all
    @tweet = Tweet.new
    @users = User.all
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).paginate(page: params[:page], per_page: 5)
  end


  def current_user?
    super || User.new
  end


  def show
    @tweet = Tweet.find(params[:id])
  end
        
  def create
    @tweet = current_user.tweets.build(tweet_params)
    respond_to do |format|
      if @tweet.save
        format.html { redirect_to @tweet, notice: 'Tweeted!' }
        format.json { render :index, status: :created, location: @tweet }
        format.js
      else
        format.html { render :new }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  

  def destroy
    @tweet = Tweet.find(params[:id])
    respond_to do |format|
      if @tweet.destroy
        format.html { redirect_to tweets_path, alert: 'Tweet Deleted' }
        format.json { render :index, status: :created, location: @tweet }
      else
        format.html { render :new }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

 


private 

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end


  def tweet_params
  	params.require(:tweet).permit(:user_id, :content)
  end 



end
