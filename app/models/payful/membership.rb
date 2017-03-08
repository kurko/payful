module Payful
  class Membership < ActiveRecord::Base
    belongs_to :memberable, polymorphic: true
    belongs_to :service, foreign_key: :payful_service_id

    #has_and_belongs_to_many :transactions, join_table: 'payful_memberships_transactions'

    validates :base_price_days, presence: true

    before_validation :set_attributes

    scope :enabled, ->{
      where("payful_memberships.expires_at > ?", Time.now)
    }

    def self.base_price_in_cents_for_service(service, period)
      if membership = where(
          active: true,
          base_price_days: period,
          payful_service_id: service.id
        ).first
        membership.base_price_in_cents
      else
        service.price_for_period(period)
      end
    end

    def self.find_by_service(service)
      find_by_payful_service_id(service.id)
    end

    def to_s
      "#{super} -> #{service.name}"
    end

    private

    def set_attributes
      days = base_price_days
      if base_price_in_cents.blank? && days.present?
        self.base_price_in_cents = service.price_for_period(days)
      end
    end
  end
end
