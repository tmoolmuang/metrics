User.create!(
  name: 'Admin User',
  password: '123qwe',
  email: 'admin@user.com',
  role: 'admin',
  confirmed_at: DateTime.now
  # skip confirmation
)

case Rails.env
when "development"
  5.times do
    fake_first_name = Faker::Name.first_name
    fake_last_name = Faker::Name.last_name
    User.create!(
      name: fake_first_name + " " + fake_last_name,
      password: 'password',
      email: Faker::Internet.email(fake_first_name + "." + fake_last_name),
      confirmed_at: DateTime.now
      # skip confirmation
    )
  end
  
  15.times do
    App.create!(
      name: Faker::App.name,
      url: Faker::Internet.url,
      user: User.all.sample
    )
  end
  
  50.times do
    Event.create!(
      name: Faker::Space.star,
      app: App.all.sample
    )
  end

when "production"
  2.times do
    App.create!(
      name: Faker::App.name,
      url: Faker::Internet.url,
      user: User.first
    )
  end
  
  5.times do
    Event.create!(
      name: Faker::Space.star,
      app: App.all.sample
    )
  end
end

puts "Seed finished"
puts "#{User.count} fake users created"
puts "#{App.count} fake apps created"
puts "#{Event.count} fake events created"