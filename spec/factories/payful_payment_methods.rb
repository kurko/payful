FactoryGirl.define do
  factory :payful_payment_method, class: 'Payful::PaymentMethod' do
    owner_id "MyString"
    owner_type "MyString"
    service "MyString"
    method_type "MyString"
    details ""
  end
end
