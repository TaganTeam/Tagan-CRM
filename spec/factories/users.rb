FactoryGirl.define do
  factory :user do
    sequence(:email) { |i| "user#{ i }@example.com" }
    password 'password'
    password_confirmation { |user| user.password }
  end
end