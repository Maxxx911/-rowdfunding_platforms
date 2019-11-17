Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post :sign_up, to: 'users#create'
      post :sign_in, to: 'users#sign_in'
      resources :users, only: %i[update] do
        member do
          patch :change_password
        end
      end
      resources :projects, only: %i[create update destroy]
      resources :payments, only: %i[create]
      resources :comments, only: %i[create update destroy]
      resources :categories, only: %i[create destroy]
    end
  end
end
