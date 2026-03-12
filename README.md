# SSActivewear

Ruby client for the [S&S Activewear](https://www.ssactivewear.com/) API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "ssactivewear"
```

And then execute:

```bash
bundle install
```

Or install it yourself as:

```bash
gem install ssactivewear
```

## Usage

### Configuration

```ruby
Ssactivewear.configure do |config|
  config.account_number = "your_account_number"
  config.api_key = "your_api_key"
end
```

Or set environment variables and skip the configure block entirely:

```bash
export SSACTIVEWEAR_ACCOUNT_NUMBER=your_account_number
export SSACTIVEWEAR_API_KEY=your_api_key
```

### Client

```ruby
client = Ssactivewear.client
```

You can also create a client with different credentials:

```ruby
client = Ssactivewear::Client.new(account_number: "other", api_key: "other_key")
```

### Categories

```ruby
categories = client.categories.list
categories.first.name         # => "3/4 Sleeve"
categories.first.category_id  # => 81

category = client.categories.find(81)
```

### Brands

```ruby
brands = client.brands.list
brands.first.name           # => "Adidas"
brands.first.noe_retailing  # => true

brand = client.brands.find(31)
```

### Styles

```ruby
styles = client.styles.list
styles.first.brand_name   # => "Gildan"
styles.first.style_name   # => "5000"
styles.first.title        # => "Heavy Cotton T-Shirt"
styles.first.description  # => "<p>...</p>"

# Search
results = client.styles.search("Gildan 5000")

# Find by ID, part number, or brand name
style = client.styles.find(39)
```

### Products

```ruby
# Filter by style
products = client.products.list(style: "Gildan 5000")
products.first.sku          # => "G500BL00011"
products.first.brand_name   # => "Gildan"
products.first.color_name   # => "Black"
products.first.size_name    # => "S"
products.first.piece_price  # => 3.28
products.first.qty          # => 14523

# Nested warehouse data
products.first.warehouses.first.warehouse_abbr  # => "IL"
products.first.warehouses.first.qty             # => 5000

# Find by SKU, SkuID, or GTIN
product = client.products.find("G500BL00011")

# Filter by warehouse
products = client.products.list(style: 39, Warehouses: "IL,KS")

# Return specific fields only
products = client.products.list(style: 39, fields: "sku,piecePrice,qty")
```

### Inventory

```ruby
inventory = client.inventory.list(style: "Gildan 5000")
inventory.first.sku  # => "G500BL00011"
inventory.first.warehouses.first.qty  # => 5000

# Filter by warehouse
inventory = client.inventory.list(style: 39, Warehouses: "NV")
```

### Specs

```ruby
specs = client.specs.list(style: 39)
specs.first.spec_name  # => "Neck Size"
specs.first.value      # => "15.5"
specs.first.size_name  # => "S"
```

### Orders

```ruby
# List orders
orders = client.orders.list
orders = client.orders.list(All: true)  # last 3 months

# Find by order number, PO number, or invoice number
order = client.orders.find("ABC123")
order.order_status     # => "Shipped"
order.tracking_number  # => "1Z999..."
order.total            # => 78.72

# Create an order
order = client.orders.create(
  shippingAddress: {
    customer: "ACME Corp",
    address: "123 Main St",
    city: "Chicago",
    state: "IL",
    zip: "60601"
  },
  shippingMethod: "1",
  poNumber: "PO-12345",
  lines: [
    { identifier: "G500BL00011", qty: 24 }
  ]
)

# Cancel an order
client.orders.cancel("ABC123")
```

### Invoices

```ruby
invoices = client.invoices.list
invoice = client.invoices.find("INV-123")
```

### Tracking

```ruby
tracking = client.tracking.list
tracking = client.tracking.find("ABC123")
```

### Error Handling

```ruby
begin
  client.products.find("INVALID")
rescue Ssactivewear::NotFoundError => e
  puts e.message  # => "Requested item(s) were not found..."
  puts e.status   # => 404
rescue Ssactivewear::AuthenticationError => e
  puts "Bad credentials"
rescue Ssactivewear::RateLimitError => e
  puts "Slow down! Rate limit exceeded"
rescue Ssactivewear::BadRequestError => e
  puts e.message
rescue Ssactivewear::ApiError => e
  puts "Something went wrong: #{e.message}"
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bundle exec rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/frameworkprint/ssactivewear.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
