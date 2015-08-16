class AmbassadorsController < ApplicationController
  before_filter :authenticate_account!
  before_filter :set_ambassador, only: [ :refer ]

  # GET /ambassadors (TODO: ask Kurt, is index the root?)
  def index
  end

  # POST /ambassadors/refer
  def refer
    fails = [] # failed referrals

    # Refer Emails if they haven't been referred already.
    if !params[:email_refers].nil?
      params[:email_refers].split(',').each do |email|
        # Make a new account for this person if they don't exist
        if Ambassador.find_by_email(email).nil?
          new_referral = Ambassador.new(email: email, status: 'prospective', parent: @ambassador )
          DefaultMailer.send_new_referral_email( @ambassador, new_referral ).deliver
          new_referral.save
        else
          fails << email
        end
      end
    end

    if !params[:text_refers].nil?
      params[:text_refers].split(',').each do |phone|
        # Make a new account for this person if they don't exist
        if !Ambassador.where(phone: phone).any?
          new_referral = Ambassador.new(phone: phone, status: 'prospective', parent: @ambassador )
          DefaultMailer.send_new_referral_text( @ambassador, new_referral ).deliver
          new_referral.save
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ambassador
      @ambassador = current_account.meta
    end

end
