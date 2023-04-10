class Apartment < ApplicationRecord
  has_many :reservations, dependent: :destroy
  has_many :users, through: :reservations

  validates :name, presence: true, length: { minimum: 2, maximum: 30, message: 'must be between 2 and 30 characters' }
  validates :description, presence: true
  validate :validate_photo_url
  validates :city, presence: true, length: { minimum: 2, maximum: 30, message: 'must be between 2 and 30 characters' }
  validates :price, presence: true, numericality: { greater_than: 0, message: "must be greater than zero" }

  private

  def validate_photo_url
    return unless photo

    unless URI.parse(photo).is_a?(URI::HTTP) || URI.parse(photo).is_a?(URI::HTTPS)
      errors.add(:photo, "must be a valid URL format")
    end
  rescue URI::InvalidURIError
    errors.add(:photo, "must be a valid URL format")
  end
end
