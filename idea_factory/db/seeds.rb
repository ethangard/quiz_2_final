# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


Idea.destroy_all
Review.destroy_all
Like.destroy_all
User.destroy_all

PASSWORD = "123"

super_user = User.create(
  name: "Admin",
  email: "test@test.com",
  password: PASSWORD
)

20.times do 
  name = Faker::Name.name
  User.create(
    name: name,
    email: "#{name}@fakeEmail.com",
    password: PASSWORD
  )
end

users = User.all

75.times do

  created_at = Faker::Date.backward(days: 365 * 5)

  i = Idea.create(
    title: Faker::Hacker.say_something_smart,
    description: Faker::ChuckNorris.fact,
    created_at: created_at,
    updated_at: created_at,
    user: users.sample
  )

  if i.valid?
    rand(1..7).times do
    Review.create(rating: rand(1..5), body: Faker::Hacker.say_something_smart, idea: i, user: users.sample)
    end
     i.likers = users.shuffle.slice(0, rand(users.count))
  end
end

ideas = Idea.all
reviews = Review.all

puts "You've generated #{ideas.count} ideas into the database :)"
puts "You've generated #{reviews.count} reviews into the database :)"
puts "You've generated #{users.count} users into the database :)"
puts "You've generated #{Like.count} likes into the database :)"