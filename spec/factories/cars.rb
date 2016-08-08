FactoryGirl.define do
  factory :car do
    sequence(:name) { |i| "name#{ i }_example" }
    price '10000'
  end
end