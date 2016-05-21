class HomeController < ShopifyApp::AuthenticatedController
  
  def index # will need to filter on pages
    keyword = params[:keyword]
    #params[:keyword] = "hello"
    collection = params[:collection]
    type = params[:type]


    # add each non empty field to filter calls
    # permutation or accumulated filtering approach


    @products = ShopifyAPI::Product.find(:all, :params => {:limit => 10, :title => keyword})
    # filterins is easy. think of approach for multi attribute filters
    @collections = ShopifyAPI::CustomCollection.find(:all,:params => {:limit => 10})
  end
  
  def rec_modal # needs to take current product
    @products = ShopifyAPI::Product.find(:all, :params => {:limit => 10})
  end

  def search
    puts "hello world"
    redirect_to "/index"
  end
  
  def get_number_of_matches(pid) # freq ptrn mining
    5
  end
  
  helper_method :get_number_of_matches
end
