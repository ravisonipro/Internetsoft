require 'faker'


# User.create!(
#   email: 'ravi_admin@gmail.com',
#   password: '12345678',
#   role: 'super_admin',
#   first_name: 'Ravi',
#   last_name: 'Super Admin',
#   mobile_number: '9998887766',
#   pin: 1234
# )

require 'faker'

Faker::UniqueGenerator.clear  # Clear Faker's unique state

25.times do
  email = Faker::Internet.unique.email
  mobile_number = Faker::PhoneNumber.unique.phone_number
  pin = Faker::Number.unique.number(digits: 4)
  password = "password123"  # Set a default password for all users

  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    mobile_number: mobile_number,
    email: email,
    pin: pin,
    password: password,
    password_confirmation: password
  )
end
