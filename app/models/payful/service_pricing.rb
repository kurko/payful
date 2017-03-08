module Payful
  class ServicePricing < ActiveRecord::Base
    belongs_to :service
  end
end
