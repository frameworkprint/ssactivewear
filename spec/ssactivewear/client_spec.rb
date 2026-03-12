# frozen_string_literal: true

RSpec.describe Ssactivewear::Client do
  before do
    Ssactivewear.configure do |config|
      config.account_number = "test_account"
      config.api_key = "test_key"
    end
  end

  after { Ssactivewear.reset! }

  subject(:client) { described_class.new }

  it "uses global configuration by default" do
    expect(client.config.account_number).to eq("test_account")
    expect(client.config.api_key).to eq("test_key")
  end

  it "allows overriding credentials" do
    custom = described_class.new(account_number: "other", api_key: "other_key")
    expect(custom.config.account_number).to eq("other")
    expect(custom.config.api_key).to eq("other_key")
  end

  it "provides resource accessors" do
    expect(client.categories).to be_a(Ssactivewear::Resources::Category)
    expect(client.styles).to be_a(Ssactivewear::Resources::Style)
    expect(client.products).to be_a(Ssactivewear::Resources::Product)
    expect(client.brands).to be_a(Ssactivewear::Resources::Brand)
    expect(client.inventory).to be_a(Ssactivewear::Resources::Inventory)
    expect(client.specs).to be_a(Ssactivewear::Resources::Spec)
    expect(client.orders).to be_a(Ssactivewear::Resources::Order)
    expect(client.invoices).to be_a(Ssactivewear::Resources::Invoice)
    expect(client.tracking).to be_a(Ssactivewear::Resources::Tracking)
  end

  describe "error handling" do
    let(:stubs) { Faraday::Adapter::Test::Stubs.new }
    let(:client) do
      c = described_class.new
      conn = Faraday.new(url: c.config.base_url) do |f|
        f.response :json
        f.adapter :test, stubs
      end
      allow(c).to receive(:connection).and_return(conn)
      c
    end

    it "raises AuthenticationError on 401" do
      stubs.get("/v2/styles/") { [401, {}, ""] }
      expect { client.get("styles/") }.to raise_error(Ssactivewear::AuthenticationError)
    end

    it "raises NotFoundError on 404" do
      stubs.get("/v2/products/INVALID") { [404, {}, '{"message":"not found"}'] }
      expect { client.get("products/INVALID") }.to raise_error(Ssactivewear::NotFoundError)
    end

    it "raises BadRequestError on 400" do
      stubs.get("/v2/orders/") { [400, {}, '{"message":"bad request"}'] }
      expect { client.get("orders/") }.to raise_error(Ssactivewear::BadRequestError)
    end

    it "raises RateLimitError on 429" do
      stubs.get("/v2/styles/") { [429, {}, ""] }
      expect { client.get("styles/") }.to raise_error(Ssactivewear::RateLimitError)
    end

    it "raises ServerError on 500" do
      stubs.get("/v2/styles/") { [500, {}, ""] }
      expect { client.get("styles/") }.to raise_error(Ssactivewear::ServerError)
    end

    it "returns array of Resources for array response" do
      stubs.get("/v2/categories/") do
        [200, {"Content-Type" => "application/json"}, '[{"categoryID":1,"name":"T-Shirts"}]']
      end
      result = client.get("categories/")
      expect(result).to be_an(Array)
      expect(result.first).to be_a(Ssactivewear::Resource)
      expect(result.first.name).to eq("T-Shirts")
    end

    it "returns a Resource for hash response" do
      stubs.get("/v2/categories/1") do
        [200, {"Content-Type" => "application/json"}, '{"categoryID":1,"name":"T-Shirts"}']
      end
      result = client.get("categories/1")
      expect(result).to be_a(Ssactivewear::Resource)
      expect(result.category_id).to eq(1)
    end
  end
end
