class User < ActiveRecord::Base
  validates :username, presence: true, uniqueness: true
  validates :admin, inclusion: { in: [true, false] }
  validates :email, presence: true, format: { with: /@/ }
end
