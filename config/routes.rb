Rails.application.routes.draw do

  resources :dash_board
  resources :users , :school do
    member do
      get :delete
    end
  end
  #  Setting route page to login page
  devise_scope :super_admin do
    authenticated :super_admin do
      root to: 'school#index', as:  :authenticated_root
    end
    root to: "super_admin/sessions#new"
  end
  
  devise_for :super_admins, controllers: {
    sessions: 'super_admin/sessions',
    registrations: 'super_admin/registrations',
    invitations: 'super_admin/invitations'
  }
  
end