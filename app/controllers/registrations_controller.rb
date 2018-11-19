class RegistrationsController < ApplicationController

  def create
    @user = User.new(email_registration_params)
    @user.registration_type = 'email'
    @user.handle_email_registration
    # OK
  rescue
    # KO
  end

  def facebook_create
    @user = User.new(facebook_registration_params)
    @user.registration_type = 'facebook'
    @user.handle_facebook_registration
    # OK
  rescue
    # KO
  end

  private

  def email_registration_params
    params.require(:user).permit(:email, :password)
  end

  def facebook_registration_params
    params.require(:user).permit(:email, :facebook_token)
  end
end
