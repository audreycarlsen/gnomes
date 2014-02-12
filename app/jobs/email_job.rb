class EmailJob
  @queue = :email

  def self.perform(array)
    post_id = array[0]
    user_id = array[1]
    NewsMailer.new_post(post_id, user_id).deliver
  end
end