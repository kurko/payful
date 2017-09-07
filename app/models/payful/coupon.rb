module Payful
  class Coupon < ActiveRecord::Base
    TYPES = [
      "discount"
    ].freeze

    validates :code, :amount, :coupon_type, presence: true
    after_initialize :nil_valid_from

    private

    def nil_valid_from
      if valid_from.blank?
        self.valid_from = Time.now
      end
    end
  end
end
