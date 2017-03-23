Rails.application.routes.draw do

  root 'pages#index'

  resources :pages do
    member do
      get 'ppc'
      get 'organic'
    end
  end

end
