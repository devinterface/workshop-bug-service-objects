require_relative 'service_object/errors'

module ServiceObject
  attr_reader :result

  module ClassMethods
    def call(*args)
      new(*args).call
    end
  end

  def self.prepended(base)
    base.extend ClassMethods
  end

  def call
    fail NotImplementedError unless defined?(super)

    @called = true
    @result = super

    self
  end

  def success?
    called? && !failure?
  end

  def failure?
    called? && errors.any?
  end

  def errors
    @errors ||= Errors.new
  end

  private

  def called?
    @called ||= false
  end
end
