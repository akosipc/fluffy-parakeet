module Services
  class OrderProcessorError < StandardError; end
  class OrderProcessorArgumentError < StandardError; end

  class OrderProcessor
    def initialize(collection, request, options = {})
      @collection = collection
      @request = request
      @order = Schema::Order.new(base_request: request)

      @options = options
    end

    def process!
      before_process

      build_order_items

      after_process
    end

    private 

    def build_order_items
      if product = @collection.find{ |m| m.code == @order.product_code }
        wat = recurse(product, product.packs.sort_by!{ |p| p.quantity }.reverse!)
      else
        raise OrderProcessorArgumentError, "Product Code is invalid. Given #{@order.product_code}"
      end
    end

    def recurse(product, packs)
      do_recurse(packs, @order.quantity, [])
    end

    def do_recurse(packs, order_quantity, acc)
      return acc if order_quantity <= 0

      selected_pack = packs.find{ |p| p.quantity <= order_quantity }

      acc << Schema::OrderItem.new({
        quantity: selected_pack.quantity,
        currency: selected_pack.currency,
        pack_id: selected_pack.id,
        amount: selected_pack.price
      })

      do_recurse(packs, order_quantity - selected_pack.quantity, acc)
    end

    def before_process
      raise OrderProcessorArgumentError, "Collection is invalid." if @collection.empty? || @collection.nil?
      raise OrderProcessorArgumentError, "Order Request is invalid. Given: #{@request}" if @request.empty? || !@order.valid?

      @order.parse_request
    end

    def after_process
      # Add more stuff here like I don't know sending stuff
    end
  end
end
