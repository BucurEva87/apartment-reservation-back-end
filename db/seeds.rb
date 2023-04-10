# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Create a test user
User.create!(
  name: 'BucurEva',
  email: 'bucur.eva87@gmail.com',
  password: '123456',
  role: 'admin'
)

# Create a test apartment
Apartment.create!(
  name: 'Luxurious Villa',
  description: 'The first housing unit on our list',
  city: 'Las Vegas',
  price: 1788.24
)

# Create a test reservation
Reservation.create!(
  start_date: Time.now,
  end_date: Time.now + 5 * 24 * 3600,
  apartment: Apartment.first,
  user: User.first
)
