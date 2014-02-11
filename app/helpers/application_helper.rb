module ApplicationHelper

  def admin_user(u)
    u.admin == true
  end

end
