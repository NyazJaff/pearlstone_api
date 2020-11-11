Rails.application.routes.draw do
  get 'welcome_page/welcome'
  root 'welcome_page#welcome'
  get 'invoice/render_pdf/:id', to: 'invoice#render_pdf',  :defaults => { :format => 'html' }
  resources :invoice, only: [:show], :defaults => { :format => 'html' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
