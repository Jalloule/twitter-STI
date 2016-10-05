class Notification < ActiveRecord::Base
  belongs_to :follow

  scope :unseen, -> { where(seen: false) }
  scope :seen, -> { where(seen: true) }
  scope :unaccepted, -> { joins(:follow).merge(Follow.not_accepted) }
  # scope :unaccepted, -> { joins(:follow).where(follows: {accepted: false}) }
  # inner join follows on follows.id = notifications.follow_id where follows.accepted = false

  delegate :follower_name, to: :follow, allow_nil: true

  def self.mark_as_seen_for(user)
    user.notifications.unseen.update_all(seen: true)
  end
end