class AmbassadorsController < ApplicationController
  before_filter :authenticate_account!
  before_filter :set_ambassador!

  # GET /ambassadors (TODO: ask Kurt, is index the root?)
  def index
  end

  # POST /ambassadors/refer
  def refer
    # Refer Emails if they haven't been referred already.
    if !params[:email_refers].nil?
      params[:email_refers].split(',').each do |email|
        # made a new account for this person
        acct = Account.new(email: email)
        acct.save(validates: false)

        new_referral = Ambassador.new(status: 'prospective', parent: @ambassador, account: acct)
        new_referral.save
      end
    end


  end

  private
  def set_ambassador!
    @ambassador = current_account.meta
  end

end
