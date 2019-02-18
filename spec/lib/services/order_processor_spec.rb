require 'spec_helper'

RSpec.describe Services::OrderProcessor, type: :services do
  let!(:processor) { Services::OrderProcessor.new(collection, "10 VS5") }
end
