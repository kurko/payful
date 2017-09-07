require 'rails_helper'

module Payful
  RSpec.describe Coupon, type: :model do
    let(:valid_from) { nil }

    subject { Coupon.new(valid_from: valid_from) }

    describe 'callbacks' do
      describe 'valid_from' do
        context "nil" do
          it 'sets to today' do
            expect(subject.valid_from.day).to   eq Time.now.day
            expect(subject.valid_from.month).to eq Time.now.month
            expect(subject.valid_from.year).to  eq Time.now.year
          end
        end

        context "not nil" do
          let(:valid_from) { Time.new(2010, 10, 10, 1, 1, 1) }
          it 'does not change' do
            expect(subject.valid_from.day).to   eq 10
            expect(subject.valid_from.month).to eq 10
            expect(subject.valid_from.year).to  eq 2010
          end
        end
      end
    end
  end
end
