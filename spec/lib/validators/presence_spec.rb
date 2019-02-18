require 'spec_helper'

RSpec.describe Validators::Presence, type: :validator do
  let!(:instance) { Base.new }

  describe "#validate!" do
    let!(:validator) { Validators::Presence.new(instance, value, true) }

    context 'value was passed is not nil' do
      let!(:value) { "wat" }

      it "returns true and doesn't add any error message" do
        expect(validator.validate!).to be_truthy
        expect(instance.errors.any?).to be_falsey
      end
    end

    context 'value was passed is a empty string' do
      let!(:value) { "" }

      it "returns false and adds an error" do
        expect(validator.validate!).to be_falsey
        expect(instance.errors[0][:message]).to eq "You are supposed to be present"
      end
    end
  end
end
