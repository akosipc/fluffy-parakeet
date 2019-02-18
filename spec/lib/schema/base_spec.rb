require 'spec_helper'

RSpec.describe Schema::Base, type: :schema do
  let!(:schema) { Schema::Base.new }

  describe "#valid" do
    it "returns true if there are no errors" do
      expect(schema.valid?).to be_truthy
    end
  end
end
