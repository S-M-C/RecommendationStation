class HomeController < ShopifyApp::AuthenticatedController
  
  def index
    @products = ShopifyAPI::Product.find(:all, :params => {:limit => 10})
    @collections = ShopifyAPI::CustomCollection.find(:all,:params => {:limit => 10})
  end
  
  def rec_modal
    @products = ShopifyAPI::Product.find(:all, :params => {:limit => 10})
  end
  
  def get_number_of_matches(pid)
    5
  end
  
  def search
    puts "hello world"
    redirect_to "/index"
  end
  
  helper_method :get_number_of_matches
end
