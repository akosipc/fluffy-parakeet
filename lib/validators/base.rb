module Validators
  class NotImplementedError < StandardError; end

  class Base
    def initialize(instance, value, expectation)
      @instance = instance
      @value = value
      @expectation = expectation
    end

    def validate!
      raise NotImplementedError, "##{__method__} must be implemented in subclass"
    end

    private

    def add_message(message)
      @instance.errors << { message: message }
      false
    end
  end
end
