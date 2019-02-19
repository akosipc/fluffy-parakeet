require_relative '../schema/permutation'

module Services
  class PermutationMaker
    def initialize(collection, value, options = {})
      @collection = collection
      @value = value

      @options = options
    end

    def make
      {}.tap do |hash|
        @collection.each do |member|
          dividend = @value / member
          remainder = @value % member

          hash[member] = Schema::Permutation.new(
            value: member,
            dividend: dividend,
            remainder: remainder,
            permutations: remainder.zero? ? [] : Services::PermutationMaker.new(possible_permutations(member), @value - (member * dividend)).make
          )
        end
      end
    end

    def valid_permutations
      make.collect{ |_key, perm| perm if perm.valid? }.reject(&:nil?)
    end

    private

    def possible_permutations(value)
      @collection.reject{ |x| x >= value }
    end
  end
end
