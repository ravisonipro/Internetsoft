class User < ApplicationRecord
  before_create :generate_unique_pin
  # Include default devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, :last_name, :mobile_number, presence: true
  
  enum role: { user: 'user', super_admin: 'super_admin' }
  validates :role, inclusion: { in: roles.keys }

  # before_create :generate_unique_pin

  private

  def generate_unique_pin
    self.pin ||= loop do
      random_pin = rand(1000..9999)  # Generates a random 4-digit pin
      break random_pin unless User.exists?(pin: random_pin)  # Ensures uniqueness
    end
  end
end
