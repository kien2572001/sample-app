# # Generate microposts for a subset of users.
30.times do |n|
  name = "User #{n+1}"
  email = "example-#{n+1}@railstutorial.org"
  password = "123456"
  User.create!(name:  name,
                email: email,
                password: password,
                password_confirmation: password,
                activated: true,
                activated_at: Time.zone.now)
end

users = User.order(:created_at).take(6)
50.times do |n|
  content = "Noi dung #{n+1}"
  users.each { |user| user.microposts.create!(content: content) }
end
