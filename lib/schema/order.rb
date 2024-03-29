require_relative './order_item'

module Schema
  class Order < Base
    BASE_REQUEST_REGEX = /\A\d+\s[A-Z0-9]+\z/

    attribute :quantity,      Integer
    attribute :base_request,  String
    attribute :product_code,  String
    attribute :order_items,   Array[Schema::OrderItem]
    attribute :total_amount,  Decimal, default: 0.0
    attribute :currency,      String,  default: "$"

    validates :base_request, presence: true
    validates :base_request, format: { with: BASE_REQUEST_REGEX }

    def parse_request
      self.quantity, self.product_code = self.base_request.split(' ') if valid?
    end

    def compute
      order_items.sum{ |x| x.amount }
    end

    def render_details
      puts "---------------"
      order_items.each_with_index do |oi, index|
        puts "#{index + 1}. #{oi.quantity} x #{oi.pack.quantity} - #{oi.currency}#{oi.amount}"
      end
      puts "---------------"

      puts "Total: #{currency} #{compute}"
    end
  end
end
