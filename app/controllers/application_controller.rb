class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout :layout

  protected
  def devise_parameter_sanitizer
    if resource_class == Account
      AccountParams.new(Account, :account, params)
    else
      super # Use the default one
    end
  end

  private
  def layout
    # Disable layout for Devise
    ( is_a?(Devise::ConfirmationsController) || is_a?(Devise::SessionsController) ||
      is_a?(Devise::RegistrationsController) || is_a?(Devise::UnlocksController)  ||
      is_a?(Devise::PasswordsController)     || is_a?(Devise::OmniauthCallbacksController) ) ?
      "devise" : "application"
  end
end
