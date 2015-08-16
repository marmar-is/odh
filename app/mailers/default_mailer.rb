class DefaultMailer < ApplicationMailer

  # Send the new referral an email
  def send_new_referral_email(referrer, referree)
    @referrer = referrer
    @referree = referree

    headers['X-SMTPAPI'] = {
      category: 'Referral',
      to: referree.email
    }.to_json

    mail( from: 'invitations@odh.com', to: referree.email, subject: 'You have been invited to ODH' )
  end

end
