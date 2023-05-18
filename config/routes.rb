Rails.application.routes.draw do
  get 'avatars/create'
  devise_for :users

  scope '/checkout' do
    post 'create', to: 'checkout#create', as: 'checkout_create'
    get 'success', to: 'checkout#success', as: 'checkout_success'
    get 'cancel', to: 'checkout#cancel', as: 'checkout_cancel'
  end

  resources :events do
    resources :attendances
  end
  root to: 'events#index'

  resources :users do
    resources :avatars, only: [:create]
  end
end