FactoryGirl.define do
  factory :user do
    sequence :username do |n| 
      "User #{n}" 
    end
    
    admin :false
  end
end