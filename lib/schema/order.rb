module Schema
  class Order < Base
    BASE_REQUEST_REGEX = /\A\d+\s[A-Z0-9]+\z/
    attribute :quantity,      Integer
    attribute :base_request,  String
    attribute :product_code,  String

    validates :base_request, presence: true
    validates :base_request, format: { with: BASE_REQUEST_REGEX }

    def parse_request
      self.quantity, self.product_code = self.base_request.split(' ') if valid?
    end
  end
end
