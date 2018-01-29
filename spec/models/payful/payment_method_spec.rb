require 'rails_helper'

module Payful
  RSpec.describe PaymentMethod, type: :model do
    describe "callbacks" do
      let(:owner) { create(:webhook) }

      describe "is_default" do
        context "when editing method" do
          let!(:creditcard1) { create(:payment_method, owner: owner, is_default: true) }
          let!(:creditcard2) { create(:payment_method, owner: owner) }
          let!(:creditcard3) { create(:payment_method, owner: owner) }

          it "changes is_default to the first in db when main credit card is deleted" do
            expect(creditcard1.is_default).to eq true
            expect(creditcard2.is_default).to eq false
            creditcard1.destroy
            creditcard2.reload
            expect(creditcard2.is_default).to eq true
          end

          it "changes is_default when a new credit card is created and set as default" do
            expect(creditcard1.is_default).to eq true
            expect(creditcard2.is_default).to eq false
            expect(creditcard3.is_default).to eq false

            new_creditcard = create(:payment_method, owner: owner, is_default: true)

            expect(new_creditcard.is_default).to eq true
            creditcard1.reload
            expect(creditcard1.is_default).to eq false
          end

          it "model stop trying to set default credit card when there is no credit card to set as default" do
            expect(creditcard1.is_default).to eq true
            expect(creditcard2.is_default).to eq false
            expect(creditcard3.is_default).to eq false
            creditcard1.destroy
            creditcard2.destroy
            creditcard3.destroy
          end
        end
      end

      context 'when first card' do
        it "create credit card with is_default being true when it is the first credit card created" do
          new_creditcard = create(:payment_method, owner: owner, is_default: false)
          expect(new_creditcard.is_default).to eq true
        end
      end
    end
  end
end
