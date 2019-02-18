require 'spec_helper'
require_relative '../support/bakery_helper'

RSpec.describe Services::OrderProcessor, type: :services do
  include BakeryHelper

  let!(:order_request) { nil }
  let!(:processor) { Services::OrderProcessor.new(setup_bakery, order_request) }

  describe '#process!' do
    context 'when order_request is valid' do
      let!(:order_request) { "10 VS5" }

      it 'computes the order and order_items' do
        processor.process!
      end
    end

    context 'when order_request is also valid' do
      let!(:order_request) { "14 MB11" }

      it 'computes the order and order_items' do
        processor.process!
      end
    end

    context 'when order_request is really also valid' do
      let!(:order_request) { "13 CF" }

      it 'computes the order and order_items' do
        processor.process!
      end
    end

    context 'when order_request is empty' do
      let!(:order_request) { "" }

      it 'raises an error saying that the order_request parameter is empty' do
        expect {
          processor.process!
        }.to raise_error(Services::OrderProcessorArgumentError, "Order Request is invalid. Given: #{order_request}")
      end
    end

    context 'when order_request is not valid' do
      let!(:order_request) { "xx 1234" }

      it 'raises an error saying that the order_request parameter is empty' do
        expect {
          processor.process!
        }.to raise_error(Services::OrderProcessorArgumentError, "Order Request is invalid. Given: #{order_request}")
      end
    end

    context 'when order_request is valid but product_code is not' do
      let!(:order_request) { "10 VSX" }

      it 'raises an error saying that the product_code is invalid' do
        expect {
          processor.process!
        }.to raise_error(Services::OrderProcessorArgumentError, "Product Code is invalid. Given VSX")
      end
    end

    context 'when collection is empty' do
      let!(:setup_bakery) { [] }

      it 'raises an error saying that the collection parameter is empty' do
        expect {
          processor.process!
        }.to raise_error(Services::OrderProcessorArgumentError, "Collection is invalid.")
      end
    end
  end
end
