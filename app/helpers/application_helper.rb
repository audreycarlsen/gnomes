module ApplicationHelper

  def admin_user(u)
    u.admin == true
  end

  def eu
    eu = EventsUser.find_by(user_id: current_user.id, event_id:@event.id)
  end
end
