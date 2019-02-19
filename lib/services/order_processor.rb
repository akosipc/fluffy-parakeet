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

      product, sorted_packs = find_product_and_packs
      perms = make_permutations(sorted_packs)
      @order.order_items = build_order_items(sorted_packs, discover_best_perm(perms))

      #after_process
      @order
    end

    private 

    def find_product_and_packs
      if product = @collection.find{ |m| m.code == @order.product_code }
        sorted_packs = product.packs.sort_by!{ |p| p.quantity }.reverse!

        [product, sorted_packs]
      else
        raise OrderProcessorArgumentError, "Product Code is invalid. Given #{@order.product_code}"
      end
    end

    def make_permutations(sorted_packs)
      Services::PermutationMaker.new(sorted_packs.collect(&:quantity), @order.quantity).make
    end

    def discover_best_perm(perms)
      perms.select{ |_key, perm| return perm if perm.valid? }
    end

    def build_order_items(sorted_packs, perm)
      do_build_order_items(sorted_packs, perm, [])
    end

    def do_build_order_items(sorted_packs, perm, acc)
      selected_pack = sorted_packs.find{ |p| p.quantity == perm.value } 

      acc << Schema::OrderItem.new({
        quantity: perm.dividend,
        currency: selected_pack.currency,
        pack_id: selected_pack.id,
        amount: selected_pack.price * perm.dividend,
        pack: selected_pack
      })

      return acc if perm.permutations.empty?

      do_build_order_items(sorted_packs, discover_best_perm(perm.permutations), acc)
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
