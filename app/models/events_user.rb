class EventsUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  def self.find_or_create_by(event_id, user_id, response)
    event_user = EventsUser.find_by(event_id: event_id, user_id:user_id) || EventsUser.create(event_id: event_id, user_id: user_id)
    event_user.update(response: response)
    return event_user
  end
end
