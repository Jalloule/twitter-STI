class FollowersController < ApplicationController
  before_filter :authenticate_user!

  def show
    @followers = user.follower_users
  end

  private

  def user
    @user ||= User.find(params[:user_id])
  end


end