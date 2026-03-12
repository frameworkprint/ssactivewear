# frozen_string_literal: true

RSpec.describe Ssactivewear::Resource do
  subject(:resource) do
    described_class.new(
      "brandName" => "Gildan",
      "styleID" => 39,
      "piecePrice" => 3.28,
      "warehouses" => [
        {"warehouseAbbr" => "IL", "qty" => 100}
      ],
      "shippingAddress" => {"city" => "Chicago", "state" => "IL"}
    )
  end

  it "converts camelCase keys to snake_case" do
    expect(resource.brand_name).to eq("Gildan")
  end

  it "preserves integer values" do
    expect(resource.style_id).to eq(39)
  end

  it "preserves decimal values" do
    expect(resource.piece_price).to eq(3.28)
  end

  it "coerces nested hashes to Resources" do
    expect(resource.shipping_address).to be_a(described_class)
    expect(resource.shipping_address.city).to eq("Chicago")
  end

  it "coerces arrays of hashes to arrays of Resources" do
    expect(resource.warehouses).to be_an(Array)
    expect(resource.warehouses.first).to be_a(described_class)
    expect(resource.warehouses.first.warehouse_abbr).to eq("IL")
  end

  it "supports bracket access" do
    expect(resource[:brand_name]).to eq("Gildan")
  end

  it "returns a hash with to_h" do
    expect(resource.to_h).to be_a(Hash)
    expect(resource.to_h[:brand_name]).to eq("Gildan")
  end

  it "responds to attribute methods" do
    expect(resource).to respond_to(:brand_name)
  end

  it "raises NoMethodError for unknown attributes" do
    expect { resource.nonexistent }.to raise_error(NoMethodError)
  end

  it "has a readable inspect" do
    expect(resource.inspect).to include("brand_name=\"Gildan\"")
  end
end
