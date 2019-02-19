require 'spec_helper'

RSpec.describe Services::PermutationMaker, type: :service do
  let!(:service1) { Services::PermutationMaker.new([8, 5, 2], 17) }
  let!(:service4) { Services::PermutationMaker.new([9, 5, 3], 18) }
  let!(:service5) { Services::PermutationMaker.new([5, 3], 10) }

  #let!(:service2) { Services::PermutationMaker.new([8, 5, 2], 14) }
  #let!(:service3) { Services::PermutationMaker.new([9, 5, 3], 13) }
  #let!(:service6) { Services::PermutationMaker.new([5, 3], 23) }
  #let!(:service7) { Services::PermutationMaker.new([4, 2], 9) }

  describe "#make!" do
    it "creates a permutation matrix for given collection and numeral need to be attained" do
      output = service1.make!

      expect(output[8][:division]).to eq 2
      expect(output[8][:remainder]).to eq 1
      expect(output[8][:permutations].length).to eq 2

      expect(output[5][:division]).to eq 3
      expect(output[5][:remainder]).to eq 2
      expect(output[5][:permutations].length).to eq 1

      expect(output[2][:division]).to eq 8
      expect(output[2][:remainder]).to eq 1
      expect(output[2][:permutations].length).to eq 0
    end

    it "creates a permutation matrix for given collection and numeral need to be attained" do
      output = service4.make!

      expect(output[9][:division]).to eq 2
      expect(output[9][:remainder]).to eq 0
      expect(output[9][:permutations].length).to eq 0

      expect(output[5][:division]).to eq 3
      expect(output[5][:remainder]).to eq 3
      expect(output[5][:permutations].length).to eq 1

      expect(output[3][:division]).to eq 6
      expect(output[3][:remainder]).to eq 0
      expect(output[3][:permutations].length).to eq 0
    end

    it "creates a permutation matrix for given collection and numeral need to be attained" do
      output = service5.make!

      expect(output[5][:division]).to eq 2
      expect(output[5][:remainder]).to eq 0
      expect(output[5][:permutations].length).to eq 0

      expect(output[3][:division]).to eq 3
      expect(output[3][:remainder]).to eq 1
      expect(output[3][:permutations].length).to eq 0
    end
  end
end
