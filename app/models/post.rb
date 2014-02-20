class Post < ActiveRecord::Base
 validates_presence_of :title, :content


  def previous
    Post.where(["id < ?", id]).last
  end

  def next
    Post.where(["id > ?", id]).first
  end
end
