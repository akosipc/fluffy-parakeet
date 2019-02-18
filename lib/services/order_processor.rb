module Services
  class OrderProcessorError < StandardError; end

  class OrderProcessor
    def initialize(collection, request, options = {})
      @collection = collection
      @request = request
      @options = options
    end

    def process!
    end
  end
end
