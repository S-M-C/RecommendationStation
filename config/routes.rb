Rails.application.routes.draw do
  mount ShopifyApp::Engine, at: '/'
  
  get 'rec_modal' => "home#rec_modal", :as => :rec_modal
  get 'search' => "home#search", :as => :search
  get 'index' => "home#index", :as => :index
  
  root :to => 'home#index'
 
end
