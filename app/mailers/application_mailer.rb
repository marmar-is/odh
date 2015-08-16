class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@marmar.is"
  layout 'mailer'
end
