FactoryGirl.define do
  factory :webhook, :class => 'Payful::Webhook' do
    source "gateway"
    source_reference_id "transaction-id"
    event "invoice.status_changed"
    data {
      {
        "event" => "invoice.status_changed",
        "data" => {
          "id" => "remote-id-1234",
          "status" => "paid",
          "account_id" => "account-id-6577"
        }
      }
    }
  end
end
