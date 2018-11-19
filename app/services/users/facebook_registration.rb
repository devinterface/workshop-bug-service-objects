require 'service_object'
module Users
  class FacebookRegistration
    prepend ServiceObject
  
    def initialize(email, facebook_token)
      @email = email
      @facebook_token = facebook_token
    end
  
    def call
      @user = User.new(email: @email, active: true, activated_at: Time.now)
      begin
        ActiveRecord::Base.transaction do
          @user.save
          create_jwt_authorization
          create_facebook_authorization
        end
      rescue
        errors.add(:error, 'something went wrong!')
      end
      @user
    end

    private 

    def create_jwt_authorization
      @user.authorizations.create(provider: 'jwt', key: SecureRandom.hex)
    end

    def create_facebook_authorization
      @user.authorizations.create(provider: 'facebook', key: @facebook_token)
    end
  end
end