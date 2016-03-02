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
    render json: {message: "success"}
  end

end
