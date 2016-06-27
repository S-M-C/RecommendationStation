require 'ShopifyApiWrapper'

class HomeController < ShopifyApp::AuthenticatedController
  # get filtering working
  # multi paging
  # refactor and cleanup
  
  def index # will need to filter on pages
    limit = 10
    keyword = params[:keyword]
    collection = params[:collection]
    type = params[:type]

    # add each non empty field to filter calls
    @collections = ShopifyApiWrapper.get_all_collections
    @types = ShopifyApiWrapper.get_all_types

  
    @products = ShopifyApiWrapper.search_by_parameters(:keyword => keyword, :collection => collection, :type => type )
    
  end

  def rec_modal # needs to take current product and suggestions page ( second window for business facing part )
    @products = ShopifyAPI::Product.find(:all, :params => {:limit => 10 } )
  end

  def search
    redirect_to "/index"
  end
  
  def get_number_of_matches(pid) # freq ptrn mining
    5
  end
  
  helper_method :get_number_of_matches
  helper_method :intersect
  helper_method :get_products_by_kwrd
  helper_method :get_products_by_coll
  helper_method :get_products_by_type
end

