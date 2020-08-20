class HomeController < ApplicationController
  before_action :authenticate_user!, except: [:welcome]

  def welcome
    @tweets = Tweet.all
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
end
