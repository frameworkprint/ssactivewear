# frozen_string_literal: true

RSpec.describe Ssactivewear do
  after { described_class.reset! }

  it "has a version number" do
    expect(Ssactivewear::VERSION).not_to be_nil
  end

  describe ".configure" do
    it "yields configuration" do
      described_class.configure do |config|
        config.account_number = "12345"
        config.api_key = "secret"
      end

      expect(described_class.configuration.account_number).to eq("12345")
      expect(described_class.configuration.api_key).to eq("secret")
    end
  end

  describe ".client" do
    it "returns a Client instance" do
      expect(described_class.client).to be_a(Ssactivewear::Client)
    end
  end

  describe ".reset!" do
    it "resets configuration to defaults" do
      described_class.configure { |c| c.account_number = "override" }
      described_class.reset!
      expect(described_class.configuration.account_number).not_to eq("override")
    end
  end
end
