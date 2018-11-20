class BackgroundUserCreateJob < ApplicationJob
  queue_as :urgent

  def perform
    message_json = {email: '', password: ''} # FETCH ME FROM RABBITMQ
    outcome = ::Users::EmailRegistration.call(message_json.email, message_json.password)
    if outcome.success?
      # OK
    else
      # KO
    end
  end
end
