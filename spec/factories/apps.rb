FactoryGirl.define do
  factory :app do
    name Faker::App.name
    url Faker::Internet.url
    user nil
  end
end
