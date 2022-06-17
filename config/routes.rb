Rails.application.routes.draw do

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
    :passwords => 'users/passwords',
    :confirmations => 'users/confirmations',
    :unlocks => 'users/unlocks',
  }

  devise_scope :user do
    root :to => "users/sessions#new"
    get "signup", :to => "users/registrations#new"
    get "verify", :to => "users/registrations#verify"
    get "login", :to => "users/sessions#new"
    delete "logout", :to => "users/sessions#destroy"

    get "week", :to => "home#week"
    get "home", :to => "home#index"
  end

  resource :users, only: [:edit, :update] do
    collection do
      get "mypage", :to => "users#edit"
      put "mypage", :to => "users#update"
      patch 'mypage/withdrawal' => 'users#withdrawal', as: 'withdrawal'
    end
  end
  get "home" => "home#index"
  resources :outfits
  
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
