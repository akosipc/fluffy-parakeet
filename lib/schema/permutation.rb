module Schema
  class Permutation < Base
    attribute :value,         Integer
    attribute :dividend,      Integer
    attribute :remainder,     Integer
    attribute :permutations,  Hash

    def valid?
      if permutations.any?
        permutations.each { |_key, object| return false unless object.valid?  }
      else
        remainder == 0 && permutations.length == 0
      end
    end
  end
end
