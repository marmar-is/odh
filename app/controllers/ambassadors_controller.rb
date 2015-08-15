class AmbassadorsController < ApplicationController
  before_filter :authenticate_account!
  before_filter :set_ambassador!

  # GET /ambassadors (TODO: ask Kurt, is index the root?)
  def index
  end

  # POST /ambassadors/refer
  def refer
    params[:email_refers].each do |email|
      new_referral = Ambassador.new(status: 'prospective', parent: @ambassador, account: Account.new)
      new_referral.save

    end
  end

  private
  def set_ambassador!
    @ambassador = current_account.meta
  end

end
