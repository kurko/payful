module Payful
  module CustomerConcern
    extend ActiveSupport::Concern

    included do
      has_many :memberships, as: :memberable, class_name: "Payful::Membership", dependent: :destroy
      has_many :services, class_name: "Payful::Service", through: :memberships
      has_many :transactions, class_name: "Payful::Transaction", as: :owner

      accepts_nested_attributes_for :memberships
      accepts_nested_attributes_for :services
    end
  end
end
