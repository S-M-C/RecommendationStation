class HomeController < ShopifyApp::AuthenticatedController
  
  def index
    @products = ShopifyAPI::Product.find(:all, :params => {:limit => 10})
    @collections = ShopifyAPI::CustomCollection.find(:all,:params => {:limit => 10})
    @types = @products.map{|product| [product.product_type,0]}.uniq.delete_if{|type| type[0].nil? || type[0].empty?}

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
