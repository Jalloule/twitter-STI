class FollowsController < ApplicationController
  before_filter :authenticate_user!

  def create
    user_follower = UserFollower.new(current_user, user)

    if user_follower.follow_user
      flash[:success] = 'You are following this person now!'
      redirect_to user_path(user)
    else
      flash[:warning] = 'Something happened! Try again.'
      redirect_to user_path(user)
    end
  end

  def destroy
    follow = load_follow

    follow.destroy if follow
    flash[:warning] = 'You are not following this person anymore!'
    redirect_to user_path(user)
  end

  private

  def user
    @user ||= User.find(params[:user_id])
  end

  def load_follow
    current_user.followings(followed_id: user.id).first
  end

end