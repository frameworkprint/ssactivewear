# frozen_string_literal: true

RSpec.describe Ssactivewear::Configuration do
  subject(:config) { described_class.new }

  it "has default base_url" do
    expect(config.base_url).to eq("https://api.ssactivewear.com/v2")
  end

  it "has default media_type" do
    expect(config.media_type).to eq("json")
  end

  it "reads account_number from ENV by default" do
    expect(config.account_number).to eq(ENV["SSACTIVEWEAR_ACCOUNT_NUMBER"])
  end

  it "reads api_key from ENV by default" do
    expect(config.api_key).to eq(ENV["SSACTIVEWEAR_API_KEY"])
  end

  it "allows setting account_number" do
    config.account_number = "12345"
    expect(config.account_number).to eq("12345")
  end

  it "allows setting api_key" do
    config.api_key = "secret"
    expect(config.api_key).to eq("secret")
  end
end
