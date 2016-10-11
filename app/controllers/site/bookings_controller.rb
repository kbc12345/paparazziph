require 'net/smtp'
require 'rubygems'
require 'mailfactory'
require 'twilio-ruby'
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

    message = <<-EOF
      Thank you for your interest in our service, we will contact you as soon as we possible to finalize your booking.
      
      In the mean time, our proposal is attached in this email which contains some info/terms of our service.

      Should you have any questions, you may contact us @ 09778055808 for faster response.

      Regards,
      ThePaparazziTeam
    EOF

    mail = MailFactory.new()
    mail.to = "#{params[:booking]["client_email"]}"
    mail.from = "no-reply@paparazziph.com"
    mail.subject = "Booking Request Received"
    mail.text = message
    if params[:booking]["category"] == "Photoman"
      mail.attach('app/assets/files/paparazzi-photoman-proposal.docx')
    else
      mail.attach('app/assets/files/photo-coverage.docx')
    end

    smtp = Net::SMTP.new 'smtp.sparkpostmail.com', 587
    smtp.enable_starttls
    smtp.start('sparkpostmail.com', ENV["sparkpost_username"], ENV["sparkpost_password"], :login)
    smtp.send_message mail.to_s(), 'no-reply@paparazziph.com', params[:booking]["client_email"]
    smtp.finish

    account_sid = "ACbed882135a28a45fba1514d51cf9106a"
    auth_token = "acd2c680aeda08da72ce6e83ac4f771f"
    @client = Twilio::REST::Client.new(account_sid, auth_token)

    @client.messages.create(
      from: '+12015523568',
      to: '+639778055808',
      body: '#{params[:booking]["client_name"]} has submit a booking. please check your email.'
    )

    render json: {}
  end
end