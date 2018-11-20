class BackgroundUserCreateJob < ApplicationJob
  queue_as :urgent

  def perform(email, password)
    outcome = ::Users::EmailRegistration.call(email, password)
    if outcome.success?
      # OK
    else
      # KO
    end
  end
end
