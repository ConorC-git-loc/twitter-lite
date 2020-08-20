class CommentsController < ApplicationController
  before_action :set_tweet
  before_action :authenticate_user!

  def create
    @comment = @tweet.comments.new(comment_params)
    @comment.user_id = current_user.id
    @comment.save
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :tweet_id)
  end

  def set_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end
end
