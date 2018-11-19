require 'bcrypt'
require 'service_object'
module Users
  class EmailRegistration
    prepend ServiceObject
  
    def initialize(email, password)
      @email = email
      @password = password
    end
  
    def call
      @user = User.new(email: @email,
                      hashed_password: BCrypt::Password.create(@password),
                      activation_token: SecureRandom.hex)
      begin
        ActiveRecord::Base.transaction do
          @user.save!
          create_jwt_authorization
          send_activation_email
        end
      rescue
        errors.add(:error, 'something went wrong!')
      end
      @user
    end

    private 

    def create_jwt_authorization
      @user.authorizations.create!(provider: 'jwt', key: SecureRandom.hex)
    end

    def send_activation_email
      ActivationMailer.send_activation_email(@email, @user.activation_token).deliver_now
    end

  end
end