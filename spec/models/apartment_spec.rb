require 'rails_helper'

RSpec.describe Apartment, type: :model do
  apartment = Apartment.find_or_create_by(name: "Test Apartment") do |a|
    a.description = 'An apartment used for testing purposes',
    a.city = 'New Delhi',
    a.price = 2038.5
  end

  describe 'associations' do
    it { should have_many(:reservations).dependent(:destroy) }
    it { should have_many(:users).through(:reservations) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(2).is_at_most(30) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:city) }
    it { should validate_length_of(:city).is_at_least(2).is_at_most(30) }
    it { should validate_presence_of(:price) }
    it { should validate_numericality_of(:price).is_greater_than(0) }

    context 'when photo is present' do
      it 'validates photo URL format' do
        apartment.photo = 'invalid_url'
        expect(apartment).not_to be_valid
        expect(apartment.errors[:photo]).to include('must be a valid URL format')

        apartment.photo = 'https://example.com/image.jpg'
        expect(apartment).to be_valid
      end
    end

    context 'when photo is not present' do
      it 'does not validate photo URL format' do
        apartment.photo = nil
        expect(apartment).to be_valid
      end
    end
  end
end
