require 'spec_helper'

RSpec.describe Validators::Numericality, type: :validator do
  let!(:instance) { Base.new }

  describe "#validate!" do
    context "validator was passed the truthy expectation" do
      let!(:validator) { Validators::Numericality.new(instance, value, true) }

      context 'value was passed is a number' do
        let!(:value) { 4 }

        it "doesn't add the error message in the instance model that was passed" do
          expect(validator.validate!).to be_truthy
          expect(instance.errors.any?).to be_falsey
        end
      end

      context 'value was passed is a number but as a string' do
        let!(:value) { "4.0" }

        it "doesn't add the error message in the instance model that was passed" do
          expect(validator.validate!).to be_truthy
          expect(instance.errors.any?).to be_falsey
        end
      end

      context 'value was passed is not a number' do
        let!(:value) { "xxx" }

        it 'adds an error message to the base model' do
          expect(validator.validate!).to be_falsey
          expect(instance.errors[0][:message]).to eq "You are supposed to be a number"
        end
      end
    end

    context "validator was passed the falsey expectation" do
      let!(:validator) { Validators::Numericality.new(instance, value, false) }

      context 'value was passed is a number' do
        let!(:value) { 4 }

        it "adds an error message to the base model" do
          expect(validator.validate!).to be_falsey
          expect(instance.errors[0][:message]).to eq "You are not supposed to be a number"
        end
      end

      context 'value was passed is not a number' do
        let!(:value) { "xxx" }

        it "doesn't add the error message in the instance model that was passed" do
          expect(validator.validate!).to be_truthy
          expect(instance.errors.any?).to be_falsey
        end
      end
    end
  end
end
