require 'spec_helper'
require_relative '../support/bakery_helper'

RSpec.describe Services::OrderProcessor, type: :services do
  include BakeryHelper

  let!(:order_request) { nil }
  let!(:processor) { Services::OrderProcessor.new(setup_bakery, order_request) }

  describe '#process!' do
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
