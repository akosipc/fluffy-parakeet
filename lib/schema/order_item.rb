require_relative './pack'

module Schema
  class OrderItem < Base
    attribute :quantity,    Integer
    attribute :currency,    String,   default: "$"
    attribute :pack_id,     String
    attribute :amount,      Decimal,  default: 0.00
  end
end
