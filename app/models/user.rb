class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :reservations, dependent: :destroy
  has_many :apartments, through: :reservations

  validates :name, presence: true, length: { minimum: 2, maximum: 30 }
  validates :email, presence: true,
                    format: { with: URI::MailTo::EMAIL_REGEXP },
                    uniqueness: { case_sensitive: false }
  validates :role, inclusion: { in: %w[user admin] }

  def self.authenticate!(email, password)
    user = find_by(email: email.downcase)
    user if user&.valid_password?(password)
  end
end
