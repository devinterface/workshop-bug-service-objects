class RegistrationsController < ApplicationController

  def create
    @user = User.new(email_registration_params)
    if @user.save
      # OK
    else
      # KO
    end
  end

  private

  def email_registration_params
    params.require(:user).permit(:email, :password)
  end
end