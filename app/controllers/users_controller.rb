class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_search
 end
