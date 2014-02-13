class NewsMailer < ActionMailer::Base
  default from: "admin@gnomesweetgnome.com"

  def new_post(post_id, user_id)
    @post_id = post_id
    @user = User.find(user_id)
    mail(to: "#{@user.email}", subject: "News from Gnome Sweet Gnome!")
  end
end
