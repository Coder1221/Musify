Rails.application.routes.draw do
  #  Setting route page to login page
  devise_scope :super_admin do
    root to: "super_admin/sessions#new"
  end

  devise_for :super_admins, controllers: {
    sessions: 'super_admin/sessions',
    registrations: 'super_admin/registrations'
  }
end