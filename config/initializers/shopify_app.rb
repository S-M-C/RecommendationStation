ShopifyApp.configure do |config|

  config.api_key = ENV['api-key']
  config.secret = ENV['secret']
  config.scope = "read_orders, read_products"
  config.embedded_app = true
end