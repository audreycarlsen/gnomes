class User < ActiveRecord::Base
  validates :username, presence: true, uniqueness: true
  validates :admin, inclusion: { in: [true, false] }
  validates :uid, presence: true
end
