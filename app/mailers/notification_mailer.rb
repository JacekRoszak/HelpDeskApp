class NotificationMailer < ApplicationMailer
  def new_service_request(email, request, link)
    @request = request
    @link = link
    # replace email
    mail(to: 'jacekroszak1986@gmail.com', subject: 'New service request in HelpDeskApp', from: 'EmailForAppNotifications@gmail.com')
  end

  def update_service_request(email, request, link)
    @request = request
    @link = link
    mail(to: email, subject: 'Your request has been updated!')
  end
end
