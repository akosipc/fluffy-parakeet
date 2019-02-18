require 'spec_helper'

RSpec.describe Validators::Base, type: :validator do
  let!(:validator) { Validators::Base.new(Base.new, 1, {}) }

  describe "#validate!" do
    it "raises an error since it wasn't implemented yet" do
      expect {
        validator.validate!
      }.to raise_error(Validators::NotImplementedError)
    end
  end
end
