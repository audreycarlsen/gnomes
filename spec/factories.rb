FactoryGirl.define do
  factory :user do
    sequence :username do |n| 
      "User #{n}" 
    end

    sequence :uid do |n| 
      "#{n}"
    end

    admin :false
  end

  factory :admin do
    sequence :username do |n| 
      "Admin #{n}" 
    end

    sequence :uid do |n| 
      "#{n}"
    end

    admin :true
  end
end