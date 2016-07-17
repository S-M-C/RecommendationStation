require 'ShopifyApiWrapper'

class HomeController < ShopifyApp::AuthenticatedController
  
  def index # will need to filter on pages
    limit = params[:limit].to_i > 0 ? params[:limit].to_i : 1
    keyword = params[:keyword]
    collection = params[:collection]
    type = params[:type]
    page = params[:page].to_i

    @collections = ShopifyApiWrapper.get_all_collections
    @types = ShopifyApiWrapper.get_all_types

    @products_total = ShopifyApiWrapper.search_by_parameters(:keyword => keyword, :collection => collection, :type => type )

    pages = @products_total.length / limit
    @products = get_paged_result(@products_total, page, limit)
  end


  def get_paged_result(all_products, page_num, num_per_page)
    print page_num
    print "-------"
    all_products[ ( (page_num-1) * num_per_page) .. ((page_num * num_per_page)-1) ]
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

end

