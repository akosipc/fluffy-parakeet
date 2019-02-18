module Schema
  class Pack < Base
    attribute :quantity,  Integer,  default: 0
    attribute :currency,  String,   default: "$"
    attribute :price,     Decimal,  default: 0.00

    validates :quantity, :price, numericality: true
    validates :quantity, :currency, :price, presence: true
  end
end
