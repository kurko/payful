require 'rails_helper'

module Payful
  RSpec.describe Service, type: :model do
    describe '#monthly_price' do
      subject do
        Payful::Service.setup('manufacture', [
          { days: 30,  amount_in_cents: 19900  },
          { days: 90,  amount_in_cents: 53700  },
          { days: 180, amount_in_cents: 101400 },
          { days: 365, amount_in_cents: 191000 }
        ])
      end

      context 'valid monthly price' do
        it 'returns 19900' do
          subject
          expect(subject.monthly_price).to eq 19900
        end
      end
    end
  end
end
