# config/initializers/twilio.rb

# set up a client to talk to the Twilio REST API
$twilio_client = Twilio::REST::Client.new(Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token)
