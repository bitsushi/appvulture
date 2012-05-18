class UserMailer < ActionMailer::Base
  default from: "App Vulture <comms@appvulture.com>"
  #   en.user_mailer.manual_signup_confirmation.subject
  def manual_signup_confirmation(user)
    @greeting = "Hi"
    mail to: user.email, subject: "Sign up confirmation"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Password Reset Instructions"
  end
end
