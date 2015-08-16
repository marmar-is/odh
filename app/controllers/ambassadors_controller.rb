class AmbassadorsController < ApplicationController
  before_filter :authenticate_account!
  before_filter :set_ambassador, only: [ :refer ]

  # GET /ambassadors (TODO: ask Kurt, is index the root?)
  def index
  end

  # POST /ambassadors/refer
  def refer
    # Refer Emails if they haven't been referred already.
    if !params[:email_refers].nil?
      params[:email_refers].split(',').each do |email|
        # Make a new account for this person if they don't exist
        if Account.find_by_email(email).nil?
          #acct = Account.new(email: email)
          #acct.save(validate: false)

          new_referral = Ambassador.new(status: 'prospective', parent: @ambassador )#, account: acct)
          new_referral.save
        end
      end
    end

    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Successfully Invited Those Emails Addresses And Phone Numbers.' }
      format.json { render :index, status: :created, location: @ambassador }
    end


  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ambassador
      @ambassador = current_account.meta
    end

end
