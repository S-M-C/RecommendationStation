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
    @collections = ShopifyAPI::CustomCollection.find(:all).map{|collection| [collection.title]}.uniq.delete_if{|type| type[0].nil? || type[0].empty?}
    @types = ShopifyAPI::Product.find(:all).map{|product| [product.product_type]}.uniq.delete_if{|type| type[0].nil? || type[0].empty?}

    products_type = get_products_by_type(type)
    products_kwrd = get_products_by_kwrd(keyword)
    products_coll = get_products_by_coll(collection)

    args = []
    for item in [products_type, products_coll, products_kwrd]
      unless item.nil?
        args.append(item)
      end
    end

    products_result = intersect(args)
    # need to send products_result to index for paging
    #params[:page] = products_result.length / limit
    #page = params[:page]
    pages = products_result.length / limit
    @products = get_paged_result(products_result, page, limit)
    
  end

  def get_paged_result(all_products, page_num, num_per_page)
    print page_num
    print "-------"
    all_products[ ( (page_num-1) * num_per_page) .. ((page_num * num_per_page)-1) ]
  end

  def get_products_by_kwrd(keyword)
    unless keyword.nil? or keyword.empty?
      keyword.strip
    end
    ShopifyAPI::Product.find(:all, :params => { :title => keyword } )
  end

  def get_products_by_type(type)
    unless type.nil? or type.empty?
      result = ShopifyAPI::Product.find(:all, :params => { :product_type => type } )
    else
      result = nil
    end
    result
  end

  def get_products_by_coll(collection)
    unless collection.nil? or collection.empty?
      current_collection = ShopifyAPI::CustomCollection.find(:all, :params => { :title => collection })[0]
      result = current_collection.products
    else
      result = nil
    end
    result
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

  def intersect(args) # return ActiveResource::Collection that interesects all of those that are passed in (arb amt)
    # Each index is an ActiveResource::Collection
    # get intersect
    result = Array.new
    for item in args[0]
      item_in_all = true
      index = 1
      while item_in_all and index < args.length
        item_in_all = args[index].include?(item)
        index += 1
      end

      if item_in_all
        result.append(item)
      end
    end
    ActiveResource::Collection.new(result)
  end
  
  helper_method :get_number_of_matches
  helper_method :intersect
  helper_method :get_products_by_kwrd
  helper_method :get_products_by_coll
  helper_method :get_products_by_type
end

