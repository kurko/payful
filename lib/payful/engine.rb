module Payful
  class Engine < ::Rails::Engine
    isolate_namespace Payful

    config.autoload_paths += Dir[config.root.join('lib', '{**}')]
    config.i18n.load_path += Dir["#{config.root}/config/locale/**/*.yml"]

    initializer :append_migrations do |app|
      unless app.root.to_s.match root.to_s
        config.paths["db/migrate"].expanded.each do |expanded_path|
          app.config.paths["db/migrate"] << expanded_path
        end
      end
    end

    config.generators do |g|
      g.test_framework :rspec, fixture: false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
      g.assets false
      g.helper false
    end
  end
end
