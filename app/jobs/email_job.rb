class EmailJob
  extend HerokuResqueAutoscaler
  
  @queue = :email

  def self.perform(post_id, user_id)
    NewsMailer.new_post(post_id, user_id).deliver
  end
end