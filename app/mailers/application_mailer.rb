class ApplicationMailer < ActionMailer::Base
  default from: 'EmailForAppNotifications@gmail.com'
  layout 'mailer'
end
