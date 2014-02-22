module ApplicationHelper

  def admin_user(u)
    u.admin == true
  end

  def eu
    eu = EventsUser.find_by(user_id: current_user.id, event_id:@event.id)
  end

  def forecast
    date = Date.today
    return (date..date + 4.days).to_a
  end

  def post_content(p)
    simple_format(p.content).gsub(URI.regexp, '<a href="\0">\0</a>').html_safe

  end

end
