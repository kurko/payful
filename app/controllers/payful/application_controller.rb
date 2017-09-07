class Payful::ApplicationController < ::ApplicationController
  protect_from_forgery with: :exception

  layout Payful::Configuration.config[:layout]
end
