Payful::Engine.routes.draw do
  resource :membership
  resources :payment_methods
end
