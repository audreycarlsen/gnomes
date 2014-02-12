module ApplicationHelper

  def admin_user(u)
    u.admin == true
  end

  def eu
    eu = EventsUser.find_by(user_id: current_user.id, event_id:@event.id)
  end

  def forecast
    date = Date.today.beginning_of_week
    return (date..date + 4.days).to_a
  end
end
