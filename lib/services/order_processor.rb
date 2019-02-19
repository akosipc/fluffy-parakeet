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

      @order.order_items = build_order_items

      #after_process
      @order
    end

    private 

    def build_order_items
      if product = @collection.find{ |m| m.code == @order.product_code }
        sorted_packs = product.packs.sort_by!{ |p| p.quantity }.reverse!
        permutations = Services::PermutationMaker.new(sorted_packs.collect(&:quantity), @order.quantity).valid_permutations

        permutations.map do |perm|
          selected_pack = sorted_packs.find{ |p| p.quantity == perm.value } 

          Schema::OrderItem.new({
            quantity: perm.dividend,
            currency: selected_pack.currency,
            pack_id: selected_pack.id,
            amount: selected_pack.price * perm.dividend,
            pack: selected_pack
          })
        end
      else
        raise OrderProcessorArgumentError, "Product Code is invalid. Given #{@order.product_code}"
      end
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
