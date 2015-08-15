# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.sendgrid.net',
  :port           => '2525',
  :authentication => :plain,
  :user_name      => Rails.application.secrets.sendgrid_username,
  :password       => Rails.application.secrets.sendgrid_password,
  :domain         => 'odh.com',
  :enable_starttls_auto => true
}
