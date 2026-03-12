# frozen_string_literal: true

module Ssactivewear
  class Configuration
    attr_accessor :account_number, :api_key, :base_url, :media_type

    def initialize
      @account_number = ENV["SSACTIVEWEAR_ACCOUNT_NUMBER"]
      @api_key = ENV["SSACTIVEWEAR_API_KEY"]
      @base_url = "https://api.ssactivewear.com/v2"
      @media_type = "json"
    end
  end
end
