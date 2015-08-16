class DefaultMailer < ApplicationMailer

  # Send the new referree an email
  def send_new_referral_email(referrer, referree)
    @referrer = referrer
    @referree = referree

    headers['X-SMTPAPI'] = {
      category: 'Referral',
      to: referree.email
    }.to_json

    mail( from: 'invitations@odh.com', to: referree.email, subject: 'You have been invited to ODH' )
  end

  # Send the new referree a text message
  def send_new_referral_text(referrer, referree)
    $twilio_client.account.messages.create({
      from: "+15005550006", # Change to one of our numbers on production
      to: "#{referree.phone}",
      body: "Hello, you have been invited to use ODH by #{referrer.full_name} %> #{link_to "Sign Up Here", new_account_registration_url(registration_token: @referree.registration_token, id: @referree.id)} to create your account.",
    })
  end

end
