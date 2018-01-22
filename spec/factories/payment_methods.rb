FactoryGirl.define do
  factory :payment_method, class: 'Payful::PaymentMethod' do
    owner_id 2
    owner_type Payful::PaymentMethod
    service "iugu"
    method_type "credit_card"
    is_default false
    details {
      {
      "brand" => "brand-test",
      "token" => "token-test",
      "last4" => "last4-test",
      "full_name" => "full-name-test"
      }
    }
  end
end
