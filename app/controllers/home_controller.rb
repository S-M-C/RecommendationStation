class HomeController < ShopifyApp::AuthenticatedController
  
  def index # will need to filter on pages
    keyword = params[:keyword]
    if not keyword.nil? and not keyword.empty?
      keyword.strip!
    end
    collection = params[:collection]
    type = params[:type]

    # add each non empty field to filter calls
    @collections = ShopifyAPI::CustomCollection.find(:all,:params => {:limit => 10}).map{|collection| [collection.title]}.uniq.delete_if{|type| type[0].nil? || type[0].empty?}
    @types = ["Any"]+ShopifyAPI::Product.find(:all, :params => {:limit => 10 }).map{|product| [product.product_type]}.uniq.delete_if{|type| type[0].nil? || type[0].empty?}

    products_type = nil
    if type != "Any"
      products_type = ShopifyAPI::Product.find(:all, :params => {:limit => 10, :product_type => type } )
    end

    products_coll = nil # what about products that do not belong to a collection
    if collection != "Any"
      current_collection = ShopifyAPI::CustomCollection.find(:all, :params => {:limit => 10, :title => collection })[0]
      products_coll = current_collection.products
      for p in products_coll
        print p
      end
    end


    products_kwrd = ShopifyAPI::Product.find(:all, :params => {:limit => 10, :title => keyword } )

    @products = intersect(products_kwrd, products_coll, products_type) # find a better way to filter empty lists
    # filtering is easy. think of approach for multi attribute filters
    
  end
  
  def rec_modal # needs to take current product and suggestions page ( second window for business facing part )
    @products = ShopifyAPI::Product.find(:all, :params => {:limit => 10 } )
  end

  def search
    puts "hello world"
    redirect_to "/index"
  end
  
  def get_number_of_matches(pid) # freq ptrn mining
    5
  end

  def intersect(*args) # return ActiveResource::Collection that interesects all of those that are passed in (arb amt)
    # Each arguent is an ActiveResource::Collection
    collections = Array.new(args.length)

    collections.each_with_index do |item, index|
      collections[index] = args[index]
    end

    # get intersect
    result = Array.new
    for item in collections[0]
      item_in_all = true
      index = 1
      while item_in_all and index < collections.length
        item_in_all = collections[index].include?(item)
        index += 1
      end

      if item_in_all
        result.append(item)
      end
    end

    result = ActiveResource::Collection.new(result)



  end
  
  helper_method :get_number_of_matches
  helper_method :intersect
end

