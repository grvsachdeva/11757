class NotificationMailer < ApplicationMailer
  default from: "sachdevarockz@gmail.com"

  def send_notification(employee, sender)
    @employee = employee
    @sender = sender
    mail(to: @employee.email, subject: "Please send your current position update #{ @employee.name }" )
  end
end
