module UsersHelper

  def follow_unfollow_button(user)
    if current_user.follows?(user)
      unfollow_button(user)
    else
      follow_button(user)
    end
  end

  def follow_button(user)
    button_to('Follow', user_follows_path(user), class: 'btn btn-success')
  end

  def unfollow_button(user)
    button_to('Unfollow', user_follows_path(user), method: :delete, class: 'btn btn-danger')
  end

end
