require 'rails_helper'

RSpec.feature "Payment Method", "creation" do
  context "As a user creating a payment method" do
    scenario "I create a credit card" do
      expect(::Payful::PaymentMethod.count).to eq 0

      visit payful.new_payment_method_path

      find('#credit-card-token', visible: false).set("test-token")
      find('#credit-card-brand', visible: false).set("test-brand")
      find('#credit-card-last4', visible: false).set("test-last4")
      find('#credit-card-expires-at').set("06/36")
      find('#credit-card-full-name').set("John Wayne")

      click_on :"save-payment-method"

      new_method = ::Payful::PaymentMethod.first!
      #expect(object).to 
    end
  end
end
