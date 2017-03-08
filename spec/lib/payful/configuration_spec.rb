require 'rails_helper'

RSpec.describe Payful::Configuration do
  class DummyCharge
  end

  it '.config=' do
    described_class.config = {
      charge_class: DummyCharge
    }
  end

  it '.config' do
    described_class.config = {
      charge_class: DummyCharge
    }

    expect(described_class.config).to eq({
      charge_class: DummyCharge
    })
  end
end
