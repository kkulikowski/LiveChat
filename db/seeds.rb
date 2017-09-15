# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create default user

password = 'q1w2e3R$'
1.upto(5) do |i|
  User.create(
    email: "user-#{i}@example.com",
    password: password,
    password_confirmation: password,
    role: 0
  )
end
1.upto(5) do |i|
  User.create(
    email: "trainer-#{i}@example.com",
    password: password,
    password_confirmation: password,
    role: 1
  )
end
User.create(
  email: "admin@example.com",
  password: password,
  password_confirmation: password,
  role: 2
)