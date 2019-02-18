module Services
  class OrderProcessor
    def initialize(order, options = {})
      @order = order
      @options = options
    end

    def process!
    end
  end
end
