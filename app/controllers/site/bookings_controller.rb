require 'net/smtp'
require 'rubygems'
require 'mailfactory'
class Site::BookingsController < SiteController
  skip_before_action :verify_authenticity_token
  def create
    # redirect_to booking_submitted_index_path
    
    message = <<-EOF
      Booking Details

      Event Type: #{params[:booking]["category"]}
      Rate: #{params[:booking]["rate"]}
      Event Name: #{params[:booking]["event_title"]}
      Client Name: #{params[:booking]["client_name"]}
      Email: #{params[:booking]["client_email"]}
      Contact: #{params[:booking]["client_number"]}
      Date: #{params[:booking]["date"]}
      Start Time: #{params[:booking]["start_time"]}
      Venue Address: #{params[:booking]["venue"]}
      How did client hear about us: #{params[:booking]["comment"]}
    EOF
    mail = MailFactory.new()
    mail.to = "thepaparazziteam@gmail.com"
    mail.from = "thepaparazziteam@gmail.com"
    mail.subject = "Booking Request of #{params[:booking]["client_name"]}"
    mail.text = message
    
    smtp = Net::SMTP.new 'smtp.gmail.com', 587
    smtp.enable_starttls
    smtp.start('gmail.com', ENV["gmail_username"], ENV["gmail_password"], :login)
    smtp.send_message mail.to_s(), 'thepaparazziteam@gmail.com', 'thepaparazziteam@gmail.com'
    smtp.finish

    render json: {}
  end
end