Sppl::Application.routes.draw do
  
  resources :games do
    member do
      get :choose_players
    end
  end

  resources :game_players

  resources :matches do
    member do
      get :new_game
    end
  end
  
  resources :players do
    member do
      get :move
    end
  end

  resources :seasons do
    member do
      get :new_match
    end
  end

  resources :user_sessions
  
  resources :users
 
  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout

  root :to => "players#index"
end
