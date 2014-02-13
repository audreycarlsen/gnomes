FactoryGirl.define do
  factory :user do
    sequence :username do |n|
      "User #{n}"
    end

    sequence :uid do |n|
      "#{n}"
    end

    admin false

    sequence :email do |n|
      "user#{n}@example.com"
    end
  end

  factory :admin, class: User do
    sequence :username do |n|
      "Admin #{n}"
    end

    sequence :uid do |n|
      "#{n}"
    end

    admin true
  end

  factory :post do
    title "Hello World"
    content "This is some news you can use"
  end

  factory :event do
    title "Planting things"
    description "It's time to plant the beets, y'all."
    location "My place"
    date Time.now
  end

  factory :rsvp, class: EventsUser do
    user_id 1
    event_id 1
    response "maybe"
  end

  factory :tool do
    title "shovel"
  end
end