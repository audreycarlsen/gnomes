class Event < ActiveRecord::Base
  has_many :users, through: :events_users
  has_many :events_users
  validates :title, presence: true
  validates :date, presence: true
  validates :description, presence: true
  validates :location, presence: true

  def start_time
    date
  end
end
