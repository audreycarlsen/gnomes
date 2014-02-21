class User < ActiveRecord::Base
  has_many :events, through: :events_users
  has_many :events_users, :dependent => :destroy
  validates :username, presence: true, uniqueness: true
  validates :admin, inclusion: { in: [true, false] }
  validates :uid, presence: true, uniqueness: true
  has_many :tools

  has_many :response_yes, through: :events_users,
          :class_name => "Event",
          :source => :event,
          :conditions => ['events_users.response = ?',"yes"]

has_many  :response_maybe, through: :events_users,
          :class_name => "Event",
          :source => :event,
          :conditions => ['events_users.response = ?',"maybe"]

  def self.find_or_create_from_omniauth(auth_hash)
    user = User.find_by(uid: auth_hash["uid"].to_s) || User.create_from_omniauth(auth_hash)
    return user
  end

  private

  def self.create_from_omniauth(auth_hash)
    User.create!(
      uid:        auth_hash["uid"].to_s,
      avatar_url: auth_hash["info"]["image"],
      username:   auth_hash["info"]["name"],
    )
  rescue ActiveRecord::RecordInvalid
    nil
  end
end
