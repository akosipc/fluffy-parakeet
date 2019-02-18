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
    end

    private 

    def before_process
      raise OrderProcessorArgumentError, "Collection is invalid." if @collection.empty? || @collection.nil?
      raise OrderProcessorArgumentError, "Order Request is invalid. Given: #{@request}" if @request.empty? || !@order.valid?
    end
  end
end
