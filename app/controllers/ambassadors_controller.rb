class AmbassadorsController < ApplicationController
  include AmbassadorsHelper
  before_filter :authenticate_account!
  before_filter :set_ambassador, only: [ :index, :refer ]

  # GET /ambassadors (TODO: ask Kurt, is index the root?)
  def index
    @child_prospects = @ambassador.children.where(status: 0)
    @child_successes = @ambassador.children.where(status: [ 1, 2 ])
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
          DefaultMailer.send_new_referral_email( @ambassador, new_referral ).deliver
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
          DefaultMailer.send_new_referral_text( @ambassador, new_referral ).deliver
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

  # PUT /ambassadors/update_prospect/1
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
      if child.update(child_params)
        format.html {redirect_to root_path, notice: "Successfully Updated Child #{display_child_label(child)}."}
      else
        format.html {redirect_to root_path, notice: "Error While Updating Child #{display_child_label(child)}."}
      end
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
