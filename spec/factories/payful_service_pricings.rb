FactoryGirl.define do
  factory :payful_service_pricing, :class => 'Payful::ServicePricing' do
    service nil
period_in_days 1
amount_in_cents 1
  end

end
