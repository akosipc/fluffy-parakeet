module Services
  class OrderProcessorError < StandardError; end

  class OrderProcessor
    def initialize(collection, order, options = {})
      @collection = collection
      @order = order
      @options = options
    end

    def process!
    end
  end
end
