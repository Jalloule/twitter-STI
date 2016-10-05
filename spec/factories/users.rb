FactoryGirl.define do
  factory :user do
    name 'Pessoa'
    description 'Sou uma pessoa!'
    sequence(:email) {|n| "email_#{n}@mail.com" }
    password '123456'
    password_confirmation '123456'
  end
end
