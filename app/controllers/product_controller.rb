class ProductController < ShopifyApp::AuthenticatedController
  def about  
  	@product = ShopifyAPI::Product.find(:all, :params => {:limit => 1})
  end
end
