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
        ambas = Ambassador.find(params[:id])
      else
        raise "Attempted trickery (RegistrationsController.rb:24)"
      end
    else
      ambas = Ambassador.new
    end
    ambas.assign_attributes(ambassador_params) # update ambassador object (without saving)

    if ambas.valid?
      @ambassador = ambas
      super do |resource|
        # save the ambassador & set it as the newly created account's meta
        ambas.update( status: 'registered', parent: Ambassador.find_by_token(params[:referrer_token]),
        registration_token: nil, email: params[:account][:email] )
        resource.update(meta: ambas)

        # Create Stripe Account
        @stripe_account = Stripe::Account.create(
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
              day: ambas.dob.day,
              month: ambas.dob.month,
              year: ambas.dob.year
            },
            first_name: ambas.fname,
            last_name: ambas.lname,
            ssn_last_4: params[:ssn_last_4]
          },
          meta_data: {
            organization: 'odh'
          }
        )

        if @stripe_account
          resource.update(
            stripe_account_id: @stripe_account.id
          )
        end

      end
    else
      respond_to.html { render :new }
    end
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
