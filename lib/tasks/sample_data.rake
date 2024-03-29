namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin=User.create!(name: "Lawrence Huang",
                 email: "lawrence@haosir.com",
                 password: "welcome",
                 password_confirmation: "welcome")
    admin.toggle!(:admin)
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@haosir.com"
      password  = "welcome"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
    users = User.all(limit: 10)
    199.times do
      content = Faker::Lorem.sentence(5)
      users.each { |user| user.microposts.create!(content: content) }
    end
  end
end
