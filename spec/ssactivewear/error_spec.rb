# frozen_string_literal: true

RSpec.describe Ssactivewear::ApiError do
  it "stores status and body" do
    error = described_class.new("bad", status: 400, body: {"errors" => []})
    expect(error.status).to eq(400)
    expect(error.body).to eq({"errors" => []})
    expect(error.message).to eq("bad")
  end
end

RSpec.describe Ssactivewear::Error do
  it "is a StandardError" do
    expect(described_class.new).to be_a(StandardError)
  end
end

RSpec.describe Ssactivewear::BadRequestError do
  it "is an ApiError" do
    expect(described_class.new).to be_a(Ssactivewear::ApiError)
  end
end

RSpec.describe Ssactivewear::NotFoundError do
  it "is an ApiError" do
    expect(described_class.new).to be_a(Ssactivewear::ApiError)
  end
end

RSpec.describe Ssactivewear::RateLimitError do
  it "is an ApiError" do
    expect(described_class.new).to be_a(Ssactivewear::ApiError)
  end
end
