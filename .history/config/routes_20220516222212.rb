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
  end

  resource :users, only: [:edit, :update] do
    collection do
      get "mypage", :to => "users#edit"
      put "mypage", :to => "users#update"
    end
  end
  get "home" => "home#index"
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
