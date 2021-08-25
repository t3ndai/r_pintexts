# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
3.times do 
 user = User.create(email: Faker::Internet.email, password: ('a'*8).to_s, password_confirmation: ('a'*8).to_s, username: Faker::Internet.username)
 puts "Created a new user: #{user.username}"

 5.times do 
    snippet = Snippet.create(description: Faker::Quote.yoda, url: Faker::Internet.url, user_id: user.id)
    puts "Create a new snippet"
 end 
end 