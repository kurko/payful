FactoryGirl.define do
  factory :transaction, :class => 'Payful::Transaction' do
    amount_in_cents 50000
    payment_type 'bank_slip'
    metadata_json ActiveSupport::JSON.encode({"test" => "testv"})
    extends_memberships_for_days 30
  end
end
