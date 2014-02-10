FactoryGirl.define do
  factory :user do
    sequence :username do |n| 
      "User #{n}" 
    end

    sequence :email do |n| 
      "user#{n}@example.com"
    end

    admin :false
  end

  factory :admin do
    sequence :username do |n| 
      "Admin #{n}" 
    end

    sequence :email do |n| 
      "admin#{n}@example.com"
    end

    admin :true
  end
end