require 'rails_helper'

module Payful
  RSpec.describe Membership, type: :model do
    let(:service) do
      Payful::Service.setup(
        'service',
        [{ days: 30, amount_in_cents: 10001 }]
      )
    end

    describe 'after_validation' do
      subject do
        create(
          :membership,
          base_price_days: 30,
          base_price_in_cents: base_price_in_cents,
          service: service
        )
      end

      describe 'amount_in_cents' do
        context "when base_price_in_cents is set previously" do
          let(:base_price_in_cents) { 2222 }

          it 'keeps the set value' do
            expect(subject.base_price_in_cents).to eq 2222
          end
        end

        context "when base_price_in_cents is undefined" do
          let(:base_price_in_cents) { nil }

          it 'is populated automatically with the service value' do
            expect(subject.base_price_in_cents).to eq 10001
          end
        end
      end

      # TODO test that amount_in_cents doesn't change
    end

    describe 'scopes' do
      describe '#enabled' do
        let!(:membership) do
          described_class.create!(
            expires_at: expires_at,
            service: service,
            base_price_days: 30,
          )
        end

        context 'expires_at is later' do
          let(:expires_at) { 1.day.from_now }

          it "returns the membership" do
            expect(described_class.enabled).to eq([membership])
          end
        end

        context 'state is active and expires_at is yesterday' do
          let(:expires_at) { 1.day.ago }

          it "returns no membership" do
            expect(described_class.enabled).to eq([])
          end
        end
      end
    end

    describe '.base_price_in_cents_for_service' do
      context 'no prior membership' do
        # TODO create proper customer table and test using it
        before do
          described_class.create!(
            active: true,
            base_price_in_cents: 12,
            base_price_days: 30,
          )
        end

        it 'returns the service price' do
          price = described_class.base_price_in_cents_for_service(service, 30)
          expect(price).to eq 10001
        end
      end

      context 'existing membership' do
        before do
          described_class.create!(
            active: true,
            service: service,
            base_price_in_cents: 12,
            base_price_days: 30,
          )
        end

        it 'returns the membership price' do
          price = described_class.base_price_in_cents_for_service(service, 30)
          expect(price).to eq 12
        end
      end
    end
  end
end
