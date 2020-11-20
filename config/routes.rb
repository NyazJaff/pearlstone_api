Rails.application.routes.draw do
  get 'welcome_page/welcome'
  root 'welcome_page#welcome'
  get 'invoice/render_pdf/:id', to: 'invoice#render_pdf',  :defaults => { :format => 'html' }

  resources :invoice, only: [:show], :defaults => { :format => 'html' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace 'api' do
      namespace 'v1' do
        get "pearlstone/empty"                       => "pearlstone#empty"
        # get "pearlstone/get_by_device_id/:device_id" => "pearlstone#get_by_device_id"
        resources :pearlstone
      end
  end


  # resources :report, only: [:saving_estimate]
  get 'report/saving_estimate', to: 'report#saving_estimate'
  get 'report/get_estimate',    to: 'report#get_estimate'

end
