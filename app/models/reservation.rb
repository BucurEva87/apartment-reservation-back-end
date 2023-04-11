class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :apartment

  validates :user, presence: true
  validates :apartment, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :start_date_before_end_date
  validate :apartment_not_reserved, on: :create

  private

  def start_date_before_end_date
    return unless start_date && end_date && start_date >= end_date

    errors.add(:start_date, 'must be before end date')
  end

  def apartment_not_reserved
    return unless apartment

    if apartment.reservations.exists?([
                                        'end_date >= ? AND start_date <= ?',
                                        start_date, end_date
                                      ])
      errors.add(:apartment, 'is already reserved for this period')
    end
  end
end
