class HomeController < ApplicationController
  before_filter :authenticate_user!

  def index
    @tweets = Timeline.new(current_user, params[:page]).tweets
  end
end