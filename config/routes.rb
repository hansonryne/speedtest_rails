Rails.application.routes.draw do
  resources :speed_tests
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'speed_tests#index'
end
