class UserMailer < ApplicationMailer
  default from: 'no-reply@example.com'

  def send_temp_password(user, temp_password)
    @user = user
    @temp_password = temp_password
    mail(to: @user.email, subject: 'Your Temporary Password')
  end
end
