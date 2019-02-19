require 'spec_helper'

RSpec.describe Schema::Permutation, type: :schema do
  let!(:perm) {
    Schema::Permutation.new({
      dividend: 5,
      remainder: 0,
      permutations: {}
    })
  }

  describe "#valid?" do
    it "returns true if the remainder is 0 and permutations.length is 0" do
      expect(perm.valid?).to be_truthy
    end
  end
end

