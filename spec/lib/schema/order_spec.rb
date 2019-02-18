require 'spec_helper'

RSpec.describe Schema::Order, type: :schema do
  let!(:valid_samples) { ["10 VS5", "14 MB11", "13 CF", "100 VV2"] }
  let!(:invalid_samples) { ["xx 123", "XX 1234", "some random text", "more random text"] }

  describe "#parse_request" do
    context 'when base_request is valid' do
      let!(:order) { Schema::Order.new(base_request: "10 VS5") }

      it 'assigns the values properly' do
        order.parse_request 
        expect(order.quantity).to eq 10
        expect(order.product_code).to eq "VS5"
      end
    end

    context 'when base_request is not valid' do
      let!(:order) { Schema::Order.new(base_request: "xxx VS5") }

      it 'assigns the values properly' do
        expect(order.parse_request).to be_falsey

        expect(order.quantity).to be_falsey
        expect(order.product_code).to be_falsey
      end
    end
  end

  describe "#valid?" do
    context 'when text is valid' do
      it 'returns true' do
        valid_samples.each do |sample|
          expect(Schema::Order.new(base_request: sample).valid?).to be_truthy
        end
      end
    end

    context 'when text is not valid' do
      it 'returns false' do
        invalid_samples.each do |sample|
          expect(Schema::Order.new(base_request: sample).valid?).to be_falsey
        end
      end
    end
  end
end
