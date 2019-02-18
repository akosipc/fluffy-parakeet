module Schema
  class Product < Base
    attribute :name,  String
    attribute :code,  String
    attribute :packs, Array[Pack]

    validates :name, presence: true
    validates :code, presence: true
  end
end
