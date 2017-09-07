Payful::Engine.routes.draw do
  resources :sections, only: :index
  resource :membership
  resources :coupons

  root "sections#index"
end
