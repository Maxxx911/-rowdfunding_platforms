Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post :sign_up, to: 'users#create'
      post :sign_in, to: 'users#sign_in'
      resources :users, only: %i[update show] do
        member do
          patch :change_password
        end
      end
      resources :categories, only: %i[index]
      resources :projects, only: %i[create update destroy index show]
      resources :payments, only: %i[create index]
      resources :comments, only: %i[create update destroy]
      resources :categories, only: %i[create destroy]
      resources :payment_methods, only: %i[create index]
    end
  end
end
