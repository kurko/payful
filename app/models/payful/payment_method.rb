module Payful
  class PaymentMethod < ActiveRecord::Base
    belongs_to :ownerable, polymorphic: true

    store_accessor :details, :number, :verification_value, :expiration, :full_name

    validates :number, length: { is: 16 }
    validates :verification_value, length: { is: 3 }
    validates :expiration, length: { is: 6 }
    validates :full_name, format: { with: /\A[a-zA-Z]+\z/ }
  end
end
