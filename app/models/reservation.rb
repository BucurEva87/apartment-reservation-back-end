class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :apartment

  validate :apartment_not_reserved, on: :create

  private

  def apartment_not_reserved
    if apartment.reservations.exists?(
        "end_date >= ? AND start_date <= ?", 
        start_date, end_date)
      errors.add(:apartment, "is already reserved for this period")
    end
  end
end
