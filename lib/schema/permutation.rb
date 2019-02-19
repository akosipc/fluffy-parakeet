module Schema
  class Permutation < Base
    attribute :dividend,      Integer
    attribute :remainder,     Integer
    attribute :permutations,  Hash

    def valid?
      if permutations.any?
        permutations.each { |_key, object| return false unless object.valid?  }
      else
        remainder == 0 && permutations.count == 0
      end
    end
  end
end
