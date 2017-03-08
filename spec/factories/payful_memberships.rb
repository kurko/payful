FactoryGirl.define do
  factory :membership, :class => 'Payful::Membership' do
    association :service
    active true
    base_price_in_cents 10000
    base_price_days 30
  end
end
