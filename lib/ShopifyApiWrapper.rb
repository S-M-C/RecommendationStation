class ShopifyApiWrapper

	@@limit = 10

	def self.search_by_parameters(params)
		keyword = params[:keyword]
		type = params[:type]
		collection = params[:collection]

		products_type = get_products_by_type(type)
    products_kwrd = get_products_by_kwrd(keyword)
    products_coll = get_products_by_coll(collection)

		args = []
    for item in [products_type, products_coll, products_kwrd]
      unless item.nil? 
        args.append(item)
      end
    end

    intersect(args)
	end

	private

	def self.get_products_by_kwrd(keyword)
    unless keyword.nil? or keyword.empty?
      keyword.strip
    end
    ShopifyAPI::Product.find(:all, :params => {:limit => @@limit, :title => keyword } )
  end

  def self.get_products_by_type(type)
    unless type.nil? or type.empty?
      result = ShopifyAPI::Product.find(:all, :params => {:limit => @@limit, :product_type => type } )
    else
      result = nil
    end
    result
  end

  def self.get_products_by_coll(collection)
    unless collection.nil? or collection.empty?
      current_collection = ShopifyAPI::CustomCollection.find(:all, :params => {:limit => @@limit, :title => collection })[0]
      result = current_collection.products
    else
      result = nil
    end
    result
  end

  def self.get_all_collections()
  	ShopifyAPI::CustomCollection.find(:all).map{|collection| [collection.title]}.uniq.delete_if{|type| type[0].nil? || type[0].empty?}
  end

  def self.get_all_types()
  	ShopifyAPI::Product.find(:all).map{|product| [product.product_type]}.uniq.delete_if{|type| type[0].nil? || type[0].empty?}
  end 

  def self.intersect(args) # return ActiveResource::Collection that interesects all of those that are passed in (arb amt)
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

end