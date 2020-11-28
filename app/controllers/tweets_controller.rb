class TweetsController < ApplicationController
  before_action :set_tweet, only: %i[show update destroy retweet]
  before_action :authenticate_user!
  before_action :set_search

  def new
    @tweet = current_user.tweets.build
  end

  def index
    @tweets = Tweet.all.with_rich_text_body_and_embeds
    @tweets = @q.result(distinct: true).paginate(page: params[:tweets_page], per_page: 10).order(created_at: :desc)
    @tweet = Tweet.new
    @comment = Comment.new
    @comments = Comment.all
    @users = User.all
    @users = @search.result(distinct: true).paginate(page: params[:page], per_page: 10)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def pin
    @tweet = Tweet.find(params[:id])
    @tweet.toggle!(:pin)
    flash[:notice] = "Pinned tweet!"
    redirect_to user_path(current_user.id)
  end

  def unpin
    @tweet = Tweet.find(params[:id])
    @tweet.toggle!(:pin)
    flash[:notice] = "Unpinned tweet!"
    redirect_to user_path(current_user.id)
  end


  def current_user?
    super || User.new
  end


  def show
    @tweet = Tweet.find(params[:id])
    @comment = Comment.new
    @comments = @tweet.comments.reverse
    @comments_count = @tweet.comments.count
  end

  def create
    @tweet = current_user.tweets.build(tweet_params)
    respond_to do |format|
      if @tweet.save
        format.html { redirect_to @tweet, notice: 'Tweeted!' }
        format.json { render :index, status: :created, location: @tweet }
        format.js
      else
        format.html { redirect_to tweets_new_path, alert: 'Tweet must be 255 characters or less' }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def following
    @tweet = Tweet.new
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



  def retweet
    @retweet = @tweet.retweets.build(user: current_user)
      if @retweet.save
        redirect_to @retweet, notice: 'Retweeted!'
      else
        redirect_to root_path, alert: 'Cannot retweet'
      end
  end



  private

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def tweet_params
    params.require(:tweet).permit(:user_id, :body, :pin, { comments: [:body] })
  end
end
