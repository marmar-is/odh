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

  def make_pick
    expo = Exposition.find(params[:expo_id])

    pick = expo.picks.where(account: current_account.id).first
    pick ||= Pick.new(exposition: expo, account: current_account)

    if (params[:team] == "true")
      pick.choice = true
    else
      pick.choice = false
    end

    if pick.save
      respond_to do |format|
        #format.html { redirect_to root_path, notice: 'Successfully Chosen!' }
        format.js { render 'make_pick', locals: {expo_id: params[:expo_id], team: params[:team]}}
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ambassador
      if (current_account.meta_type == "Ambassador")
        @ambassador = current_account.meta

      end
    end

end
