class HomeController < ShopifyApp::AuthenticatedController
  
  def index
    @products = ShopifyAPI::Product.find(:all, :params => {:limit => 10})
  end
  
  def rec_modal
    @products = ShopifyAPI::Product.find(:all, :params => {:limit => 10})
  end
  
  def get_number_of_matches(pid)
    5
  end
  
  helper_method :get_number_of_matches
end
