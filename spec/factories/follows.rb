FactoryGirl.define do
  factory :follow do
    follower factory: :user
    followed factory: :user
    accepted true
  end
end