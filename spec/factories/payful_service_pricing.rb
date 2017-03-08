FactoryGirl.define do
  factory :service_pricing, :class => 'Payful::ServicePricing' do
    period_in_days 30
    amount_in_cents 19900
  end
end
