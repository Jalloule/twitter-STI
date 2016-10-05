class NotificationsController < ApplicationController
  before_filter :authenticate_user!

  def index
    load_new_notifications
    load_pending_notifications
    turn_new_notifications_seen
  end

  private

  def load_new_notifications
    @new_notifications = current_user.notifications.unseen.load
  end

  def load_pending_notifications
    @pending_notifications = current_user.
        notifications.
        seen.
        unaccepted.
        includes(follow: :follower).
        load
  end

  def turn_new_notifications_seen
    Notification.mark_as_seen_for(current_user)
  end

end
