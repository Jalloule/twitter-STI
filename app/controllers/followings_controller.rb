class FollowingsController < ApplicationController
  before_filter :authenticate_user!

  def show
    @following = user.following_users
  end

  private

  def user
    @user ||= User.find(params[:user_id])
  end


end