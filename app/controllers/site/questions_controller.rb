require 'net/smtp'
require 'rubygems'
require 'mailfactory'
class Site::QuestionsController < SiteController
  skip_before_action :verify_authenticity_token
  def create   
    message = <<-EOF
      Inquiry Details

      Name: #{params[:question]["name"]}
      Email: #{params[:question]["email"]}
      Contact: #{params[:question]["mobile"]}
      Message: #{params[:question]["message"]}
    EOF

    mail = MailFactory.new()
    mail.to = "thepaparazziteam@gmail.com"
    mail.from = "thepaparazziteam@gmail.com"
    mail.subject = "Inquiry of #{params[:question]["name"]}"
    mail.text = message

    smtp = Net::SMTP.new 'smtp.gmail.com', 587
    smtp.enable_starttls
    smtp.start('gmail.com', ENV["gmail_username"], ENV["gmail_password"], :login)
    smtp.send_message mail.to_s(), 'thepaparazziteam@gmail.com', 'thepaparazziteam@gmail.com'
    smtp.finish

    message = <<-EOF
      Thank you for you inquiry, we will reply to your question as soon as possible.
      Alternatively, you may contact us @ 09778055808 for faster response.

      Regards,
      ThePaparazziTeam
    EOF

    mail = MailFactory.new()
    mail.to = "#{params[:question]["email"]}"
    mail.from = "no-reply@paparazziph.com"
    mail.subject = "Inquiry Received"
    mail.text = message

    smtp = Net::SMTP.new 'smtp.sparkpostmail.com', 587
    smtp.enable_starttls
    smtp.start('sparkpostmail.com', ENV["sparkpost_username"], ENV["sparkpost_password"], :login)
    smtp.send_message mail.to_s(), 'no-reply@paparazziph.com', params[:question]["email"]
    smtp.finish

    render json: {message: "success"}
  end

end
