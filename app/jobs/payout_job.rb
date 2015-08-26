class PayoutJob < ActiveJob::Base
  # Perform the Payout for a new referral according to the console
  queue_as :default # default queue

  # Given a new referral, 'thank' the parents who referred him ( and their parents, etc. )
  def perform(new_referral)
    # Marmaris' customer account for payouts
    marmaris_customer = "cus_6pfktmXjY8Hozs"

    # Associated Transaction
    #sub_id = Stripe::Customer.retrieve(new_referral.account.stripe_subscription_id).subscriptions.data[0].id

    referrer = new_referral.parent
    # Payout Matrix is ordered by generation (1 .. x)
    PayoutMatrix.select(:generation, :amount).each do |p|
      if referrer
        transfer(referrer.account.stripe_account_id, p.generation, p.amount)

        referrer = referrer.parent
      else
        break
      end
    end

  end
  # perform

  private
  def transfer(stripe_account_id, generation, amount)
    Stripe::Transfer.create(
      amount:               amount*100, # Convert dollars to cents
      currency:             'USD',
      description:          'Compensation for a referral. Thanks!',
      metadata:             {
        generation:         generation,
      },
      destination:          stripe_account_id,#first_referrer.account.stripe_account_id,
      #source_transaction:   sub_id
    )
    #Stripe::Charge.create({
    #  amount:       payout_matrix[generation-1][:amount],
    #  currency:     "usd",
    #  customer:     marmaris_customer,
    #  source:       { TOKEN }, # Our marmaris account info
    #  destination:  stripe_account_id
    #  })
  end
end
