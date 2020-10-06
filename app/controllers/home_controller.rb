class HomeController < ApplicationController
  before_action :authenticate_user!, except: [:welcome]

  def welcome
    @tweets = Tweet.all
  end

  def index
    @users = User.all
  end

  def search_index
    @users = User.all
    @users = @search.result(distinct: true).paginate(page: params[:page], per_page: 10)
  end

  def show
    @user = User.find(params[:id])
    @tweet = Tweet.find(params[:id])
    @comment = Comment.new
  end
end
