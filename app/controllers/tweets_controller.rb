class TweetsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @tweet = current_user.tweets.build
  end

  def create
    @tweet = current_user.tweets.build(tweet_params)

    if @tweet.save
      flash[:success] = 'Tweet was successfully published!'
      redirect_to root_path
    else
      flash[:danger] = 'Something is wrong! Give it another try.'
      render 'new'
    end
  end

  def destroy
    @tweet = current_user.tweets.where(id: params[:id]).first
    @tweet.destroy if @tweet

    redirect_to user_path(current_user)
  end

  private
  def tweet_params
    params.require(:tweet).permit(:text)
  end
end
