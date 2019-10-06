Rails.application.routes.draw do
  
  devise_for :users
  root 'home#index'

  get 'clients/report_birthday' => 'clients#report_birthday'

  get 'products/:id/add_amount' => 'products#add_amount', as: :add_amount_product
  get 'products/:id/entry_amount' => 'products#entry_amount', as: :entry_amount_product

  get 'sales/:id/select_client' => 'sales#select_client', as: :select_client_sale
  get 'sales/:id/selection/:client_id' => 'sales#selection', as: :selection_sale
  get 'sales/:sale_id/search_item' => 'sales#search_item', as: :search_item
  post 'sales/:sale_id/items/:id' => 'items#add', as: :add_sale_item
  get 'sales/:id/confirm_print' => 'sales#confirm_print', as: :confirm_print_sale
  get 'sales/today' => 'sales#today'
  get 'sales/pending' => 'sales#pending'
  get 'sales/:id/pay' => 'sales#pay', as: :pay_sale

  get 'expenses/new_expense' => 'expenses#new_expense'
  get 'expenses/new_debt' => 'expenses#new_debt'
  get 'expenses/today' => 'expenses#today'
  get 'expenses/debts' => 'expenses#debts'
  get 'expenses/:id/pay' => 'expenses#pay', as: :pay_expense

  get 'cashes/today' => 'cashes#today'
  get 'cashes/open' => 'cashes#open', as: :open_cash

  get 'reports' => 'reports#index'
  get 'reports/sales_report' => 'reports#sales_report'
  get 'reports/expenses_report' => 'reports#expenses_report'
  get 'reports/resume_report' => 'reports#resume_report'
  get 'reports/inventory_report' => 'reports#inventory_report'
  get 'reports/amount_report' => 'reports#amount_report'
  get 'reports/salesman_report' => 'reports#salesman_report'
  get 'reports/report' => 'reports#report'

  resources :users, only:[:edit, :update]
  resources :cashes, only:[:new, :index]
  resources :expenses, only:[:create, :index, :new, :edit, :update, :show, :destroy]
  resources :clients, only:[:new, :create, :index, :show, :edit, :update, :destroy]
  resources :products, only:[:index, :new, :create, :show, :edit, :update]
  resources :sales do
    resources :items
  end
end