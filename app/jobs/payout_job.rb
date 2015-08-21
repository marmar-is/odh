class PayoutJob < ActiveJob::Base
  # Perform the Payout for a new referral according to the console
  queue_as :default # default queue

  # Given a new referral, 'thank' the parents who referred him ( and their parents, etc. )
  def perform(new_referral)
    # Payout Matrix
      # generation: number of referrers ago
      # amount:     amount to pay (in cents)
    payout_matrix = [
      { generation: 1, amount: 3000 },
      { generation: 2, amount: 2500 },
      { generation: 3, amount: 2000 },
      { generation: 4, amount: 1500 },
      { generation: 5, amount: 1000 }
    ]

    # Marmaris' customer account for payouts
    marmaris_customer = "cus_6pfktmXjY8Hozs"

    # Associated Transaction
    #sub_id = Stripe::Customer.retrieve(new_referral.account.stripe_subscription_id).subscriptions.data[0].id

    first_referrer = new_referral.parent
    if first_referrer
      transfer(first_referrer.stripe_account_id, 1)

      second_referrer = first_referrer.parent
      if second_referrer
        transfer(second_referrer.stripe_account_id, 2)

        third_referrer = first_referrer.parent
        if third_referrer
          transfer(third_referrer.stripe_account_id, 3)

          fourth_referrer = first_referrer.parent
          if fourth_referrer
            transfer(fourth_referrer.stripe_account_id, 4)

            fifth_referrer = first_referrer.parent
            if fifth_referrer
              transfer(fifth_referrer.stripe_account_id, 5)
            end
            # fifth
          end
          # fourth
        end
        # third
      end
      # second
    end
    # first
  end
  # perform

  private
  def transfer(stripe_account_id, generation)
    Stripe::Transfer.create(
      amount:               payout_matrix[generation-1][:amount],
      currency:             'USD',
      destination:          stripe_account_id#first_referrer.account.stripe_account_id,
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
