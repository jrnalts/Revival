Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html  

  get '/exchange', to: 'vouchers#new'
  get "/vouchers", to: "vouchers#index"
  resources :vouchers, path: "exchange", only: [:create] 

  get '/', to: redirect('/exchange')
end
