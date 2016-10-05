module Account
  class FollowersController < ApplicationController
    before_filter :authenticate_user!

    def index
      @follows = current_user.followers
    end

    def update
      follow.accept if follow
      flash[:success] = 'Follower accepted!'
      redirect_to notifications_path
    end

    def destroy
      follow.destroy if follow
      flash[:warning] = 'Follower rejected!'
      redirect_to notifications_path
    end

    private

    def follow
      @follow ||= current_user.followers.find_by(id: params[:id])
    end

  end
end