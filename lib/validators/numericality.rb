module Validators 
  class Numericality < Base
    def validate!
      begin
        if Kernel.Float(@value).is_a?(Numeric)
          return true if @expectation
          add_message("You are not supposed to be a number")
        else
          return true unless @expectation
        end
      rescue ArgumentError, TypeError
        @expectation ? add_message("You are supposed to be a number") : true
      end
    end
  end
end
