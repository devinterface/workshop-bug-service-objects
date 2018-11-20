class RegistrationsController < ApplicationController

  def create
    outcome = ::Users::EmailRegistration.call(email_registration_params[:user][:email], email_registration_params[:user][:password])
    if outcome.success?
      # OK
    else
      # KO
    end
  end

  def facebook_create
    outcome = ::Users::FacebookRegistration.call(facebook_registration_params[:user][:email], facebook_registration_params[:user][:facebook_token])
    if outcome.success?
      # OK
    else
      # KO
    end
  end

  private

  def email_registration_params
    params.require(:user).permit(:email, :password)
  end

  def facebook_registration_params
    params.require(:user).permit(:email, :facebook_token)
  end
end
