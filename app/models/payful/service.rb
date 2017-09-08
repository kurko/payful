module Payful
  class Service < ActiveRecord::Base
    class UndefinedPricingDays < StandardError; end

    has_many :pricing, class_name: "Payful::ServicePricing"

    def self.setup(name, pricing)
      service = nil
      ActiveRecord::Base.transaction do
        service = where(name: name).first_or_create!
        service.pricing.destroy_all
        pricing.each do |price|

          if price[:days].blank?
            raise UndefinedPricingDays, "#{service.to_s} has blank price period"
          end

          service.pricing.create!(
            period_in_days: price[:days],
            amount_in_cents: price[:amount_in_cents],
          )
        end
      end
      service
    end

    def monthly_price
      price_for_period(30)
    end

    def price_for_period(days)
      pricing.find do |price|
        price[:period_in_days] == days.to_i
      end.amount_in_cents
    end
  end
end
