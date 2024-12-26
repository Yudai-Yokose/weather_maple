Rails.application.routes.draw do
  root "cities#index"
  resources :cities, only: [:index, :show]

  get "/terms" => "terms#show"
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
