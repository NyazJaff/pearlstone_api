Rails.application.routes.draw do
  get 'welcome_page/welcome'
  root 'welcome_page#welcome'
  get 'invoice/render_pdf/:id', to: 'invoice#render_pdf',  :defaults => { :format => 'html' }
  # resources :invoice, only: [:show], :defaults => { :format => 'html' }

  namespace 'api' do
    namespace 'v1' do
      get "pearlstone/empty" => "pearlstone#empty"
      # get "pearlstone/get_by_device_id/:device_id" => "pearlstone#get_by_device_id"
      resources :pearlstone
    end
  end

  post 'user/login', to: 'user#login'
  resources :user


  post 'report/saving_estimate',  to: 'report#saving_estimate'
  get 'report/generate_estimate', to: 'report#generate_estimate'
  post 'report/saving_calculation', to: 'report#saving_calculation'
  # get 'report/get_estimate',     to: 'report#get_estimate'
end
