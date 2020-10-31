Rails.application.routes.draw do
  get 'invoices/index'
  get 'invoices/show'
  get 'welcome_page/welcome'
  root 'welcome_page#welcome'
  resources :invoices, only: [:index, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
