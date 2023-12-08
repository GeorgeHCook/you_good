Rails.application.routes.draw do
  devise_for :users
  root to: "pages#dashboard"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "up" => "rails/health#show", as: :rails_health_check

  resources :check_ins, only: %i[new create index show music]
  resources :chatrooms, only: %i[create index show] do
    resources :messages, only: :create
  end
  post "/chatrooms/:user_id", to: "chatrooms#create", as: :new_chatroom
end
