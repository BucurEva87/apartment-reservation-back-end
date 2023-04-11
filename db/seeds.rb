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

# Create a test apartments
Apartment.create!(
  name: 'Luxurious Villa',
  description: 'The first housing unit on our list',
  photo: 'https://images.pexels.com/photos/258154/pexels-photo-258154.jpeg',
  city: 'Las Vegas',
  price: 1788.24
)

Apartment.create!(
  name: 'Big Living Room',
  description: 'The second housing unit on our list',
  photo: 'https://images.pexels.com/photos/276724/pexels-photo-276724.jpeg',
  city: 'New York',
  price: 995.95
)

Apartment.create!(
  name: 'House in the country side',
  description: 'The third housing unit on our list',
  photo: 'https://images.pexels.com/photos/2510067/pexels-photo-2510067.jpeg',
  city: 'Prague',
  price: 567.89
)

# Create a test reservation
Reservation.create!(
  start_date: Time.now,
  end_date: Time.now + 5 * 24 * 3600,
  apartment: Apartment.first,
  user: User.first
)

# Doorkeeper record in oauth_application with uid/client_id and client_secret
Doorkeeper::Application.find_or_create_by(name: "React") do |app|
  app.redirect_uri = ""
  app.save!
end
