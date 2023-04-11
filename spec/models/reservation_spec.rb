require 'rails_helper'

RSpec.describe Reservation, type: :model do
  let(:user) { User.create(name: "John Doe", email: "john@example.com", password: "password123") }
  let(:apartment) { Apartment.create(name: "Cozy Apartment", description: "A cozy apartment in the heart of the city", photo: "https://images.pexels.com/photos/258154/pexels-photo-258154.jpeg", city: "New York", price: 100) }

  describe "validations" do
    it "is valid with valid attributes" do
      reservation = Reservation.new(user: user, apartment: apartment, start_date: Date.today, end_date: Date.today + 1.week)
      expect(reservation).to be_valid
    end

    it "is not valid without a user" do
      reservation = Reservation.new(apartment: apartment, start_date: Date.today, end_date: Date.today + 1.week)
      expect(reservation).to_not be_valid
    end

    it "is not valid without an apartment" do
      reservation = Reservation.new(user: user, start_date: Date.today, end_date: Date.today + 1.week)
      expect(reservation).to_not be_valid
    end

    it "is not valid without a start date" do
      reservation = Reservation.new(user: user, apartment: apartment, end_date: Date.today + 1.week)
      expect(reservation).to_not be_valid
    end

    it "is not valid without an end date" do
      reservation = Reservation.new(user: user, apartment: apartment, start_date: Date.today)
      expect(reservation).to_not be_valid
    end

    it "is not valid if the start date is after the end date" do
      reservation = Reservation.new(user: user, apartment: apartment, start_date: Date.today + 1.week, end_date: Date.today)
      expect(reservation).to_not be_valid
    end

    it "is not valid if the apartment is already reserved for the same interval" do
      existing_reservation = Reservation.create(user: user, apartment: apartment, start_date: Date.today, end_date: Date.today + 1.week)
      new_reservation = Reservation.new(user: user, apartment: apartment, start_date: Date.today, end_date: Date.today + 1.week)
      expect(new_reservation).to_not be_valid
    end
  end

  describe "associations" do
    it "belongs to a user" do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq :belongs_to
    end

    it "belongs to an apartment" do
      association = described_class.reflect_on_association(:apartment)
      expect(association.macro).to eq :belongs_to
    end
  end
end
