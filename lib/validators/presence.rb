module Validators
  class Presence < Base
    DEFAULT_MESSAGE = "You are supposed to be present"

    def validate!
      case @value.class.to_s
      when "String"
        @value.empty? ? add_message(DEFAULT_MESSAGE) : true
      when "NilClass"
        add_message(DEFAULT_MESSAGE)
      end
    end
  end
end
