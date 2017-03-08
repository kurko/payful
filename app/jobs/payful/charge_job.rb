module Payful
  class ChargeJob < ApplicationJob
    # Set the Queue as Default
    queue_as :default

    def perform(args)
      transaction = Payful::Transaction.find(args)
      charge_class = Payful::Configuration.config[:charge_class]
      charge_class
        .new(transaction, transaction.customer)
        .charge
    end
  end
end
