require 'active_support/inflector'

require_relative '../validators/base'
require_relative '../validators/presence'
require_relative '../validators/numericality'

module Schema
  class Base
    attr_accessor :errors, :validators

    def initialize
      @errors = []
    end

    def valid?
      @errors.empty?
    end

    def self.validates(attribute, validator_type)
      @validators << "validators/#{validator_type.keys[0]}".classify.constantize.new(self, self.attributes[attribute], validator_type.values[0])
    end
  end
end
