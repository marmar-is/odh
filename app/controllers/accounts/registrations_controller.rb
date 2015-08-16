class Accounts::RegistrationsController < Devise::RegistrationsController
# before_filter :configure_sign_up_params, only: [:create]
# before_filter :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
  def create
    ambas = Ambassador.new(ambassador_params)

    respond_to do |format|
      if ambas.save
        ambas.update(status: 'registered', parent: Ambassador.find_by_token(params[:referrer_token]), registration_token: nil)

        super do |resource|
          resource.update(meta: ambas)
        end
      else
        format.html { render :new }
      end
    end
  end
=begin
     do |resource|
      # TODO: params to determine type of account (when not all are ambassadors)
      ambas = Ambassador.new( status: 'registered', account: resource )
      ambas.save
      ambas.update( registration_token: nil ) # nil registration_token after registering

      # Test sending twilio message
      $twilio_client.account.messages.create({
        from: "+15005550006", # Change to one of our numbers on production
        to: "#{resource.phone}",
        body: "Hello #{resource.full_name}! Thank you for creating an account with ODH. Your Referral Token is #{resource.meta.token}.",
        })
    end
=end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

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
      params.require(:ambassador).permit(:email, :phone, :fname, :lname, :dob, :street, :city, :state, :zip)
    end
end
