require 'active_support'
require 'active_record'
require 'virtus'

module Schema
  class Base
    include Virtus.model
    
    include ActiveRecord::Validations

    attribute :id,          String, default: SecureRandom.hex(6)

    def new_record?
      true
    end

    def self._reflect_on_association(args)
    end
  end
end
