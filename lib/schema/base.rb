require 'active_support/inflector'
require 'virtus'

require_relative '../validators/base'
require_relative '../validators/presence'
require_relative '../validators/numericality'

module Schema
  class Base
    include Virtus.model

    attr_accessor :validators

    attribute :errors,      Array,  default: []

    def valid?
      errors.empty?
    end

    def self.validates(attribute, validator_type)
      @validators ||= []
      @validators << "validators/#{validator_type.keys[0]}".classify.constantize.new(self, self.attribute_set[attribute], validator_type.values[0])
    end
  end
end
