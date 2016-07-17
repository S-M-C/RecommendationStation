require 'ShopifyApiWrapper'

class HomeController < ShopifyApp::AuthenticatedController
  
  def index # will need to filter on pages
    limit = params[:limit].to_i
    keyword = params[:keyword]
    collection = params[:collection]
    type = params[:type]
    page = params[:page].to_i

    if limit == 0
      limit += 1
    end

    # add each non empty field to filter calls
    @collections = ShopifyApiWrapper.get_all_collections
    @types = ShopifyApiWrapper.get_all_types

    products_type = get_products_by_type(type, limit)
    products_kwrd = get_products_by_kwrd(keyword, limit)
    products_coll = get_products_by_coll(collection, limit)
      unless item.nil?
    products_result = intersect(args)
    # need to send products_result to index for paging
    #params[:page] = products_result.length / limit
    #page = params[:page]
    pages = products_result.length / limit
    @products = get_paged_result(products_result, page, limit)
  def get_paged_result(all_products, page_num, num_per_page)
    print page_num
    print "-------"
    all_products[ ( (page_num-1) * num_per_page) .. ((page_num * num_per_page)-1) ]
  end

  def get_products_by_kwrd(keyword)
    ShopifyAPI::Product.find(:all, :params => { :title => keyword } )
  
    @products = ShopifyApiWrapper.search_by_parameters(:keyword => keyword, :collection => collection, :type => type )
      result = ShopifyAPI::Product.find(:all, :params => { :product_type => type } )
    
  def get_products_by_coll(collection)
      current_collection = ShopifyAPI::CustomCollection.find(:all, :params => { :title => collection })[0]
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

