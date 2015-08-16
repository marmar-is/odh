class DefaultMailer < ApplicationMailer

  # Send the new referral an email
  def send_new_referral_email(referrer, referred)
    @referrer = referrer
    @referree = referred

    headers['X-SMTPAPI'] = {
      category: 'Referral',
      to: email
    }.to_json

    mail( to: referred.email, subject: 'You have been invited to ODH' )
  end

end
