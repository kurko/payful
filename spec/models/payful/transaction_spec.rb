require 'rails_helper'

module Payful
  RSpec.describe Transaction, type: :model do
    subject { create(:transaction) }

    describe 'initializing' do
      let(:tomorrow) { 1.day.from_now }
      let(:yesterday) { 1.day.ago }
      let(:service) { create(:service) }
      let(:membership1) { create_membership(19900, tomorrow) }
      let(:membership2) { create_membership(29900, yesterday) }

      context 'with memberships' do
        it 'sets the initial state' do
          transaction = Transaction.create!(
            memberships: [membership1, membership2],
            extends_memberships_for_days: 30,
            amount_in_cents: 12300
          )

          expect(transaction.state).to eq 'pending'
          expect(transaction.amount_in_cents).to eq 12300
          membership1.reload
          membership2.reload
          expect(membership1.expires_at).to eq tomorrow
          expect(membership2.expires_at).to eq yesterday
        end
      end
    end

    describe 'before_save' do
      describe "metadata" do
        it "converts metadata to json before saving" do
          expect(subject.metadata).to eq({"test" => "testv"})
          subject.metadata = { "test" => "value" }
          expect(subject.metadata).to eq({ "test" => "value" })
          subject.save!
          subject.metadata = { test2: "value2" }
          subject.save!
          subject = described_class.last
          expect(subject.metadata).to eq({ "test2" => "value2" })
          subject.update!(metadata: { "test3" => "value3" })
          expect(subject.metadata).to eq({ "test3" => "value3" })
        end

        it "keeps it persisted even when reloading the transaction" do
          subject
          transaction = Payful::Transaction.last
          expect(transaction.metadata).to eq({ "test" => "testv" })
          transaction.update!(
            extends_memberships_for_days: 2
          )
          expect(transaction.metadata).to eq({ "test" => "testv" })
        end

        it "works when it's not initialized" do
          Payful::Transaction.create!(
            amount_in_cents: 50000
          )
        end
      end
    end

    describe '.complete_this_month?' do
      context 'when there are transactions this month' do
        before do
          described_class.create!(
            amount_in_cents: 12300
          ).mark_as_complete
        end

        it 'returns true' do
          expect(described_class).to have_any_complete_this_month
        end
      end

      context 'when there are no transactions this month' do
        before do
          described_class.create!(
            amount_in_cents: 12300
          ).mark_as_complete(
            completed_at: Time.new.utc.beginning_of_month - 1.hour
          )
        end

        it 'returns false' do
          expect(described_class).to_not have_any_complete_this_month
        end
      end
    end

    describe "#state" do
      context 'when it is pending' do
        it 'is valid' do
          subject.state = 'pending'
          expect(subject).to be_valid
        end
      end

      context 'when it is complete' do
        it 'is valid' do
          subject.state = 'complete'
          expect(subject).to be_valid
        end
      end

      context 'when it is anything else' do
        it 'is valid' do
          subject.state = 'anything'
          expect(subject).to_not be_valid
        end
      end
    end

    describe '#customer' do
      let(:service) { create(:service) }
      # we don't have a customer table, so let's go with another one
      let(:memberable) { create(:service) }
      let(:membership) do
        Membership.create!(
          base_price_in_cents: 1,
          memberable: memberable,
          service: service
        )
      end

      subject do
        Transaction.create!(
          memberships: [membership],
          amount_in_cents: 12300
        )
      end

      it 'returns the first customer' do
        expect(subject.customer).to eq memberable
      end
    end

    describe '#update_payment_details' do
      let(:params) do
        {
          payment_url: "my-url",
          payment_remote_id: "12345",
        }
      end

      context 'when payment_url is nil' do
        it 'sets a value' do
          subject.update_payment_details(params)
          expect(subject.payment_url).to eq "my-url"
        end
      end

      context 'when payment_url is present' do
        it 'sets a value' do
          subject.update!(payment_url: "old-url")
          subject.update_payment_details(params)
          expect(subject.payment_url).to eq "old-url"
        end
      end
    end

    def create_membership(amount, expires_at)
      create(
        :membership,
        service: service,
        expires_at: expires_at,
        base_price_in_cents: amount
      )
    end
  end
end
