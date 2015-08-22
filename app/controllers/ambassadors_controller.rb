class AmbassadorsController < ApplicationController
  include AmbassadorsHelper
  before_filter :authenticate_account!
  before_filter :set_ambassador, only: [ :index, :refer ]

  # GET /ambassadors (TODO: ask Kurt, is index the root?)
  def index
    @child_prospects = @ambassador.children.where(status: 0)
    @child_successes = @ambassador.children.where(status: [ 1, 2 ])

    @stripe_bank_account = Stripe::Account.retrieve(current_account.stripe_account_id).bank_accounts.first
  end

  # POST /ambassadors/refer
  def refer
    fails = [] # failed referrals

    # Refer Emails if they haven't been referred already.
    if !params[:email_refers].nil?
      params[:email_refers].split(',').each do |email|
        # Make a new account for this person if they don't exist
        if Ambassador.find_by_email(email).nil?
          new_referral = Ambassador.new(email: email, referred_via: 'email',
           status: 'prospective', parent: @ambassador )
          new_referral.save

          DefaultMailer.send_new_referral_email( @ambassador, new_referral ).deliver#_later

          @ambassador.active! if !@ambassador.active? # Make ambassador active upon first referral
        else
          fails << email
        end
      end
    end

    if !params[:text_refers].nil?
      params[:text_refers].split(',').each do |phone|
        # Make a new account for this person if they don't exist
        if !Ambassador.where(phone: phone.gsub(/\D/, '') ).any?
          new_referral = Ambassador.new(phone: phone, referred_via: 'phone',
          status: 'prospective', parent: @ambassador )
          new_referral.save

          DefaultMailer.send_new_referral_text( @ambassador, new_referral ).deliver#_later

          @ambassador.active! if !@ambassador.active? # Make ambassador active upon first referral
        else
          fails << phone
        end
      end
    end

    respond_to do |format|
      format.html { redirect_to root_path, notice: "Successfully Invited Those Emails Addresses And Phone Numbers except for #{fails.join(',')}." }
      format.json { render :index, status: :created, location: @ambassador }
    end
  end

  # PATCH /ambassadors/update_prospect/1
  def update_prospect
    child = Ambassador.find(params[:id])
    if child.referred_via == 'email'
      raise "Trickery Detected (AmbassadorsController.rb:55)" if child.email != params[:child][:email]
    elsif child.referred_via == 'phone'
      raise "Trickery Detected (AmbassadorsController.rb:57)" if child.phone != params[:child][:phone].gsub(/\D/, '')
    else
      raise "Invalid Referred (AmbassadorsController.rb:59)"
    end

    respond_to do |format|
      child.assign_attributes(child_params)
      if child.changed?
        if child.save
          format.html {redirect_to root_path, notice: "Successfully Updated Child #{display_child_label(child)}."}
          format.js { render "update_prospect", locals: {child: child} }
        else
          format.html {redirect_to root_path, notice: "Error While Updating Child #{display_child_label(child)}."}
        end
      else
        format.js { render "update_prospect_nochange", locals: {child: child} }
      end
    end
  end

  # PATCH /ambassadors/update_bank_account/1
  def update_bank_account
    account = Account.find(params[:id])

    stripe_account = Stripe::Account.retrieve(account.stripe_account_id)

    stripe_account.external_account = params[:stripe_bank_token]
    stripe_account.save

    respond_to do |format|
      format.html {redirect_to root_path, notice: "Successfully Added A Bank Account"}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ambassador
      @ambassador = current_account.meta
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def child_params
      params.require(:child).permit(:email, :phone, :fname, :lname)
    end

end
