FactoryGirl.define do
  factory :user do
    sequence :username do |n|
      "User #{n}"
    end

    sequence :uid do |n|
      "#{n}"
    end

    admin false
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
end