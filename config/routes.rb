CouponsCode::Engine.routes.draw do
  resources :coupons
  root to: "coupons#index"
end
