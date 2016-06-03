class AddProductTypesTable < ActiveRecord::Migration
  def self.up
	  		create_table :product_types do |pt|
	  			pt.string :name, null: false
	  		end		

	  		add_foreign_key :product_types,:shops
  end

  def self.down
  	drop_table :product_types
  end 
end
