Rails.application.routes.draw do
  resources :kinds
  resources :contacts do
    resource :kind, only: [ :show ] # belongs_to
    resource :phones, only: [ :show ] # has_may
    resource :phone, only: [ :create, :update, :destroy ] # has_may
    resource :address, only: [ :show, :update, :create, :destroy ] # has_one
  end
end
