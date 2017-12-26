module Payful
  class PaymentMethod < ActiveRecord::Base
    belongs_to :ownerable, polymorphic: true

    attr_accessor :token
    attr_accessor :brand
    attr_accessor :last4
    attr_accessor :full_name

    validates :full_name, format: { with: /\A[a-zA-Z]+\z/ }
  end
end
