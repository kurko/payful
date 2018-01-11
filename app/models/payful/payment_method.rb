module Payful
  class PaymentMethod < ActiveRecord::Base
    belongs_to :owner, polymorphic: true

    attr_accessor :token
    attr_accessor :brand
    attr_accessor :last4
    attr_accessor :full_name

    #validates :full_name, format: { with: /\A[a-zA-Z]+\z/ }

    def details=(value)
      self.details_json = ActiveSupport::JSON.encode(value)
    end

    def details
      JSON.parse(details_json)
    end
  end
end
