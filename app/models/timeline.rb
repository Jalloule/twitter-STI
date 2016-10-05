class Timeline

  def initialize(user, page)
    @user = user
    @page = page
  end

  def tweets
    Tweet.includes(:user).where(user_id: following_ids).page(@page).per(5)
  end

  private

  def following_ids
    @user.followings.pluck(:followed_id)
  end
end




