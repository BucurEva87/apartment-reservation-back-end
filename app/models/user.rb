class User < ApplicationRecord
  has_many :reservations, dependent: :destroy
  has_many :apartments, through: :reservations

  validates :name, presence: true, length: { minimum: 2, maximum: 30, message: 'must be between 2 and 30 characters' }
  validates :email, presence: true,
                    format: { with: URI::MailTo::EMAIL_REGEXP, message: '%<value>s is not a valid email format' },
                    uniqueness: { case_sensitive: false, message: '%<value>s is already associated to an account' }
  validates :role, inclusion: { in: %w[user admin], message: '%<value>s is not a valid role' }
end