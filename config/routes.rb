Rails.application.routes.draw do
  
  root 'home#index'

  get 'clients/report_birthday' => 'clients#report_birthday'

  get 'products/:id/add_amount' => 'products#add_amount', as: :add_amount_product
  get 'products/:id/entry_amount' => 'products#entry_amount', as: :entry_amount_product

  get 'sales/:id/select_client' => 'sales#select_client', as: :select_client_sale
  get 'sales/:id/selection/:client_id' => 'sales#selection', as: :selection_sale
  get 'sales/:sale_id/search_item' => 'sales#search_item', as: :search_item
  post 'sales/:sale_id/items/:id' => 'items#add', as: :add_sale_item
  get 'sales/today' => 'sales#today'
  get 'sales/pending' => 'sales#pending'
  get 'sales/:id/pay' => 'sales#pay', as: :pay_sale

  get 'expenses/new_expense' => 'expenses#new_expense'
  get 'expenses/new_debt' => 'expenses#new_debt'
  get 'expenses/today' => 'expenses#today'
  get 'expenses/debts' => 'expenses#debts'
  get 'expenses/:id/pay' => 'expenses#pay', as: :pay_expense

  resources :expenses, only:[:create, :index, :new, :edit, :update, :show, :destroy]
  resources :clients, only:[:new, :create, :index, :show, :edit, :update, :destroy]
  resources :products, only:[:index, :new, :create, :show, :edit, :update]
  resources :sales do
    resources :items
  end
end