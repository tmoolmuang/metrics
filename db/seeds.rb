User.create!(
  name: 'Admin User',
  password: '123qwe',
  email: 'admin@user.com',
  role: 'admin')
  
5.times do
  fake_first_name = Faker::Name.first_name
  fake_last_name = Faker::Name.last_name
  User.create!(
    name: fake_first_name + " " + fake_last_name,
    password: 'password',
    email: Faker::Internet.email(fake_first_name + "." + fake_last_name)
  )
end

15.times do
  App.create!(
    name: Faker::App.name,
    url: Faker::Internet.url,
    user: User.all.sample
  )
end

puts "Seed finished"
puts "#{User.count} fake users created"
puts "#{App.count} fake apps created"