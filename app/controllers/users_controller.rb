class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_user

  def show
    @tweets = @user.tweets
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
