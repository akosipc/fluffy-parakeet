module Schema
  class Order < Base
    attribute :quantity,      Integer
    attribute :base_request,  String
    attribute :product_code,  String
  end
end
