Rails.application.routes.draw do
  mount Payful::Engine => "/payful"

  resource :coupons
end
