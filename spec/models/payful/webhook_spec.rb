require 'rails_helper'

module Payful
  RSpec.describe Webhook, type: :model do
    subject { create(:webhook) }

    describe 'after_initialize' do
      subject { Webhook.new }

      it 'sets the state to pending' do
        expect(subject.state).to eq 'pending'
      end
    end

    describe 'before_save' do
      describe "data" do
        it "converts data to json before saving" do
          expect(subject.data).to eq({
            "event" => "invoice.status_changed",
            "data" => {
              "id" => "remote-id-1234",
              "status" => "paid",
              "account_id" => "account-id-6577"
            }
          })
          subject.data = { "test" => "value" }
          expect(subject.data).to eq({ "test" => "value" })
          subject.save!
          subject.data = {
            test2: "value2",
            array: [{
              k1: "v1",
              k2: 2
            }]
          }
          subject.save!
          subject = described_class.last
          expect(subject.data).to eq({
            "test2" => "value2",
            "array" => [{
              "k1" => "v1",
              "k2" => 2
            }]
          })
          subject.update!(data: { "test3" => "value3" })
          expect(subject.data).to eq({ "test3" => "value3" })
        end

        it "keeps it persisted even when reloading the record" do
          subject
          record = Payful::Webhook.last
          expect(record.data).to eq({
            "event" => "invoice.status_changed",
            "data" => {
              "id" => "remote-id-1234",
              "status" => "paid",
              "account_id" => "account-id-6577"
            }
          })
          record.update!(
            source: 'another-gateway'
          )
          expect(record.data).to eq({
            "event" => "invoice.status_changed",
            "data" => {
              "id" => "remote-id-1234",
              "status" => "paid",
              "account_id" => "account-id-6577"
            }
          })
        end
      end
    end

    describe '#mark_as_processed' do
      it 'transactions to state processed' do
        now = Time.now.utc
        subject.mark_as_processed(now)
        expect(subject).to be_processed
        expect(subject.processed_at).to eq now
      end
    end

    describe '#processed?' do
      subject { create(:webhook, state: state) }

      context 'state is pending' do
        let(:state) { 'pending' }

        it 'returns false' do
          expect(subject).to_not be_processed
        end
      end

      context 'state is processed' do
        let(:state) { 'processed' }

        it 'returns true' do
          expect(subject).to be_processed
        end
      end
    end
  end
end
