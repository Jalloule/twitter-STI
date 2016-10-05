module NotificationsHelper
  def notification_message(param_notification)
    if current_user.need_accept?
      render partial: 'notifications/need_accept', locals: { notification: param_notification }
    else
      "Yay! #{param_notification.follower_name} is following you."
    end
  end
end
