require 'optparse'
require_relative '../lib/schema/base'
require_relative '../lib/schema/order'
require_relative '../lib/schema/product'
require_relative '../lib/schema/pack'
require_relative '../lib/services/order_processor'
require_relative '../lib/services/permutation_maker'

def setup_bakery
  [].tap do |inventory|
    vegemite = Schema::Product.new(
      name: "Vegemite Scroll",
      code: "VS5",
      packs: [
        Schema::Pack.new(quantity: 3, price: 6.99),
        Schema::Pack.new(quantity: 5, price: 8.99)
      ]
    )

    blueberry = Schema::Product.new(
      name: "Blueberry Muffin",
      code: "MB11",
      packs: [
        Schema::Pack.new(quantity: 2, price: 9.95),
        Schema::Pack.new(quantity: 5, price: 16.95),
        Schema::Pack.new(quantity: 8, price: 24.95)
      ]
    )

    croissant = Schema::Product.new(
      name: "Croissant",
      code: "CF",
      packs: [
        Schema::Pack.new(quantity: 3, price: 5.95),
        Schema::Pack.new(quantity: 5, price: 9.95),
        Schema::Pack.new(quantity: 9, price: 16.99)
      ]
    )

    inventory << vegemite << blueberry << croissant
  end
end

bakery = setup_bakery

ARGF.each do |order_request|
  begin
    order = Services::OrderProcessor.new(bakery, order_request.strip).process!
    order.render_details
  rescue Services::OrderProcessorError => e
    puts e
  end
end
