Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :lessons, only:[:index, :show, :new, :create, :destroy, :edit, :update] do
    resources :sessions, only:[:index, :destroy, :update, :new, :create] do
      collection do
        get :confirmation
      end
    end
  end
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
