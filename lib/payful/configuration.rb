module Payful
  class Configuration
    @@config ||= {
      # Class to be called after transaction was created. This is called
      # from an async worker.
      charge_class: nil,
      layout: "payful"
    }

    def self.config=(hash)
      @@config = hash
    end

    def self.config
      @@config
    end
  end
end
