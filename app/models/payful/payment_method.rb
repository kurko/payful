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


    #validates :number, length: { is: 16 }
    #validates :verification_value, length: { is: 3 }
    #validates :expires_at, length: { is: 5, wrong_length: "It must contain 4 numbers with slash between month and year like in the example" }
    #validates :full_name, format: { with: /\A[a-zA-Z]+(?: [a-zA-Z]+)?+(?: [a-zA-Z]+)?+(?: [a-zA-Z]+)?\z/, message: "Only allows letters" }

    def details=(value)
      self.details_json = ActiveSupport::JSON.encode(value)
    end

    def details
      JSON.parse(details_json)
    end

    def mark_as_default
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
      payment_methods = self.class.where(owner: owner)
      if is_default && payment_methods.present?
        payment_methods
          .find_by(is_default: false)
          .update!(is_default: true)
      end
    end
  end
end
