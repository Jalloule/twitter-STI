class UserFollower

  def initialize(follower, followed_user)
    @follower = follower
    @followed_user = followed_user
  end

  def follow_user
    follow.notifications.build && follow.save && notify_externally
  end

  private

  attr_reader :follower, :followed_user

  def follow
    @follow ||= follower.followings.build(followed_id: followed_user.id)
  end

  def notify_externally
    # TODO: implementar envio de email
    true
  end

end