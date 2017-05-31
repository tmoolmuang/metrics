User.create!(
  name: 'Admin User',
  password: '111111',
  email: 'admin@user.com',
  role: 'admin',
  confirmed_at: DateTime.now
  # skip confirmation
)
User.create!(
  name: 'Standard User',
  password: '111111',
  email: 'standard@user.com',
  role: 'standard',
  confirmed_at: DateTime.now
  # skip confirmation
)

event1 = Faker::Space.star
event2 = Faker::Space.star
event3 = Faker::Space.star
event4 = Faker::Space.star

2.times do
  App.create!(
    name: Faker::App.name,
    url: Faker::Internet.url,
    user: User.first
  )
end

15.times do
  Event.create!(
    name: event1,
    app: App.first
  )
end

35.times do
  Event.create!(
    name: event2,
    app: App.first
  )
end

5.times do
  Event.create!(
    name: event3,
    app: App.first
  )
end

45.times do
  Event.create!(
    name: event4,
    app: App.first
  )
end

puts "Seed finished"
puts "#{User.count} fake users created"
puts "#{App.count} fake apps created"
puts "#{Event.count} fake events created"