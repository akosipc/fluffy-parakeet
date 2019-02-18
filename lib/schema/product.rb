require_relative './pack'

module Schema
  class Product < Base
    attribute :name,  String
    attribute :code,  String
    attribute :packs, Array[Schema::Pack]

    validates :name, presence: true
    validates :code, presence: true
  end
end
