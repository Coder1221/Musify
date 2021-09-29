Rails.application.routes.draw do

  # get 'check_out/create'
  # get 'products/index'
  resources :lectures do
    member do
      get :delete
    end
  end
  
  resources :dash_board
  resources :check_out, only: [:create]
  # make it plural 
  resources :school , only: %i[index edit update show]

  resources :users do
    member do
      get :delete
    end
    collection do
      get 'activate_or_deactivate'
    end
  end
      
  #  Setting route page to login page
  devise_scope :super_admin do
    authenticated :super_admin do
      # root to: 'school#index', as:  :authenticated_root
      root to: 'school#edit', as: :authenticated_root
    end
    root to: "super_admin/sessions#new"
    # to change the path to remove format routes
    get '/super_admins/:id/edit', to: 'super_admin/registrations#edit',  as: 'my_route'
  end

  # scope out controllers
  devise_for :super_admins, controllers: {
    sessions: 'super_admin/sessions',
    registrations: 'super_admin/registrations',
    invitations: 'super_admin/invitations',
    omniauth_callbacks: 'super_admin/omniauth_callbacks'  
  }

end