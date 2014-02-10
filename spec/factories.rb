FactoryGirl.define do
  factory :user do
    sequence :username do |n| 
      "User #{n}" 
    end
    
    admin :false

    sequence :uid do |n| 
      "#{n}"
    end
  end
end