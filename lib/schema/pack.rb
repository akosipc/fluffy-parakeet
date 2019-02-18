module Schema
  class Pack < Base
    attribute :quantity,  Integer,  default: 0
    attribute :currency,  String,   default: "$"
    attribute :price,     Decimal,  default: 0.00

    validates :quantity, numericality: true
    validates :quantity, presence: true
    validates :currency, presence: true
    validates :price, presence: true
    validates :price, numericality: true
  end
end
