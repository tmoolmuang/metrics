FactoryGirl.define do
  fake_first_name = Faker::Name.first_name
  fake_last_name = Faker::Name.last_name
  fake_password = Faker::Lorem.characters(6)
  
  factory :user do
    name fake_first_name + " " + fake_last_name
    email Faker::Internet.email(fake_first_name + "." + fake_last_name)
    password fake_password
    password_confirmation fake_password
    role :standard
  end
end
