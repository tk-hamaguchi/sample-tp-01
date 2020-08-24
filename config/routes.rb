Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "welcome#index"
  resources :boards, only: %i[create index show update destroy]
  resources :re_pins, only: %i[create]
  resources :pins, only: %i[new create show]
end
