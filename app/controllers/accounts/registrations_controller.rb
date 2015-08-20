class Accounts::RegistrationsController < Devise::RegistrationsController
# before_filter :configure_sign_up_params, only: [:create]
# before_filter :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    if (!params[:registration_token].blank? && !params[:id].blank?) && (Ambassador.find(params[:id]).registration_token == params[:registration_token])
      @title = "ODH Sign Up - Referral"
      @ambassador = Ambassador.find(params[:id])
    else
      @title = "ODH Sign Up"
      @ambassador = Ambassador.new
    end

    super
  end

  # POST /resource
  def create
    if !params[:registration_token].blank? && !params[:id].blank?
      if Ambassador.find(params[:id]).registration_token == params[:registration_token]
        @ambassador = Ambassador.find(params[:id])
      else
        raise "Attempted trickery (RegistrationsController.rb:24)"
      end
    else
      @ambassador = Ambassador.new
    end

    build_resource(sign_up_params) # Build the devise account

    # Update Ambassador object (without saving)
    @ambassador.assign_attributes( ambassador_params.merge(email: params[:account][:email].downcase, status: 'registered') )

    if resource.valid?
      if @ambassador.valid?

        # Create Stripe Account
        begin
          stripe_account = Stripe::Account.create(
            managed: true,
            country: 'US',
            default_currency: 'USD',
            email: resource.email,
            tos_acceptance: {
              ip: request.remote_ip,
              date: Time.now.to_i,
            },
            legal_entity: {
              type: 'individual',
              dob: {
                day: @ambassador.dob.day,
                month: @ambassador.dob.month,
                year: @ambassador.dob.year
              },
              first_name: @ambassador.fname,
              last_name: @ambassador.lname,
              ssn_last_4: params[:ssn_last_4]
            },
            metadata: {
              organization: 'odh'
            }
          )
        rescue => e # Error in created Stripe Account
          clean_up_passwords resource
          set_minimum_password_length

          puts ('Stripe Account Create Error')
          flash[:error] =  e.json_body[:error]

          render :new # TODO: add error messages (using stripe errors)
        end
        # /begin

        begin
          # Charge Subscription Fee
          customer = Stripe::Customer.create({
            source:       params[:token],
            email:        resource.email,
            plan:         params[:plan_id],
            description:  "Subscription to ODH",
            metadata: {
              connect_account: stripe_account.id,
              odh_account:     resource.id
            }
          })
        rescue Stripe::CardError => e # Error in created Stripe Subscription
          error = e.json_body[:error][:message]
          flash[:error] = "Charge failed! #{error}"

          puts 'Stripe Card Error'
          Stripe::Account.retrieve(stripe_account.id).delete # remove stripe account if card is declined
          render :new # Will describe why card failed
        rescue Stripe::StripeError => e
          puts 'Stripe Error'
          flash[:error] =  e.json_body[:error]

          Stripe::Account.retrieve(stripe_account.id).delete # remove stripe account if card is declined
          render :new # Will describe why card failed
        rescue => e
          puts 'Generic Error. Not Stripe'
          flash[:error] =  e.json_body[:error]

          Stripe::Account.retrieve(stripe_account.id).delete # remove stripe account if card is declined
          render :new # Will describe why card failed
        end
        # /begin


        # update the ambassador & set it as the newly created account's meta
        @ambassador.assign_attributes( status: 'registered', parent: Ambassador.find_by_token(params[:referrer_token]),
        registration_token: nil, email: resource.email )

        # hold onto the Stripe Account ID and Stripe Customer ID
        resource.assign_attributes(meta: @ambassador,
        stripe_account_id: stripe_account.id, stripe_subscription_id: customer.id)

        # Successful Create! Save Everything
        resource.save
        @ambassador.save

        # Taken from Devise
        if resource.active_for_authentication?
          set_flash_message :notice, :signed_up if is_flashing_format?
          sign_up(resource_name, resource)
          respond_with resource, location: after_sign_up_path_for(resource)
        else
          set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
          expire_data_after_sign_in!
          respond_with resource, location: after_inactive_sign_up_path_for(resource)
        end

      else
        flash[:error] = "Charge failed! #{@ambassador.errors.messages}"

        clean_up_passwords resource
        set_minimum_password_length
        render :new # TODO: add error messages (invalid ambassador)
      end
      # /ambassador.valid?

    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
    # /resource.valid?
  end

  # GET /resource/edit
  def edit
    @ambassador = current_account.meta
    super
  end

  # PUT /resource
  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end

      current_account.meta.update(ambassador_params)
      current_account.meta.update( email: params[:account][:email] )

      sign_in resource_name, resource, bypass: true
      respond_with resource, location: after_update_path_for(resource)
    else
      @ambassador = current_account.meta
      clean_up_passwords resource
      respond_with resource
    end
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.for(:sign_up) << :attribute
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.for(:account_update) << :attribute
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def ambassador_params
      params.require(:ambassador).permit(:phone, :fname, :lname, :dob, :street, :city, :state, :zip)
    end
end
