Rails.application.routes.draw do
  mount ShopifyApp::Engine, at: '/'
  
  get 'rec_modal' => "home#rec_modal", :as => :rec_modal

  root :to => 'home#index'
 
end
