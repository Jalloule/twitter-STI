module Account
  class FollowingsController < ApplicationController
    before_filter :authenticate_user!

    def show
      @following = current_user.following_users
    end

  end
end