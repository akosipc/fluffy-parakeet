require 'spec_helper'

RSpec.describe Schema::Pack, type: :schema do
  let!(:params) do
    {
      quantity: 5,
      currency: "$",
      price: 29.99
    }
  end
  let!(:pack) { Schema::Pack.new(params) }
end
