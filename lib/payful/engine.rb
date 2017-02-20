module Payful
  class Engine < ::Rails::Engine
    isolate_namespace Payful

    config.generators do |g|
      g.test_framework :rspec
    end
  end
end
