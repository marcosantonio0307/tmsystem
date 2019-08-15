Rails.application.routes.draw do
  
  root 'home#index'

  get 'clients/report_birthday' => 'clients#report_birthday'

  get 'products/:id/add_amount' => 'products#add_amount', as: :add_amount_product
  get 'products/:id/entry_amount' => 'products#entry_amount', as: :entry_amount_product
  resources :clients, only:[:new, :create, :index, :show, :edit, :update, :destroy]
  resources :products, only:[:index, :new, :create, :show, :edit, :update]
end