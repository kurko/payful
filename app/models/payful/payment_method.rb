module Payful
  class PaymentMethod < ActiveRecord::Base
    belongs_to :owner, polymorphic: true
    before_save :mark_as_default
    after_destroy :after_default_destroyed

    attr_accessor :token
    attr_accessor :brand
    attr_accessor :last4
    attr_accessor :full_name
    attr_accessor :expires_at
    attr_accessor :verification_value
    attr_accessor :number

    def details=(value)
      self.details_json = ActiveSupport::JSON.encode(value)
    end

    def details
      JSON.parse(details_json)
    end

    def mark_as_default
      # mark is_default as true if occurs change in it and if before the change the value was false.
      # also, if it is the first record being created, turns is_default to true
      if changes[:is_default].present? && !changes[:is_default][0] && changes[:is_default][1]
        self.class
          .where(owner: owner)
          .where.not(id: id)
          .update_all(is_default: false)
      elsif self.class.where(owner: owner).count == 0
        self.is_default = true
      end
    end

    def after_default_destroyed
      # if paymentmethod being destroyed is true,
      # finds another paymentmethod and turn it into true
      payment_methods = self.class.where(owner: owner)
      if is_default && payment_methods.present?
        payment_methods
          .find_by(is_default: false)
          .update!(is_default: true)
      end
    end
  end
end
