class AccountsController < ApplicationController
  before_filter :authenticate_account!
  before_filter :set_ambassador, only: [ :index ]
  def index
    if @ambassador
      @child_prospects = @ambassador.children.where(status: 0)
      @child_successes = @ambassador.children.where(status: [ 1, 2 ])
    end
    
      @stripe_bank_account = Stripe::Account.retrieve(current_account.stripe_account_id).bank_accounts.first
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ambassador
      if (current_account.meta_type == "Ambassador")
        @ambassador = current_account.meta

      end
    end

end
