# frozen_string_literal: true

require "faraday"

module Ssactivewear
  class Client
    attr_reader :config

    def initialize(account_number: nil, api_key: nil, **options)
      @config = Configuration.new
      @config.account_number = account_number || Ssactivewear.configuration.account_number
      @config.api_key = api_key || Ssactivewear.configuration.api_key
      @config.base_url = options[:base_url] || Ssactivewear.configuration.base_url
      @config.media_type = options[:media_type] || Ssactivewear.configuration.media_type
    end

    def categories
      Resources::Category.new(self)
    end

    def styles
      Resources::Style.new(self)
    end

    def products
      Resources::Product.new(self)
    end

    def brands
      Resources::Brand.new(self)
    end

    def inventory
      Resources::Inventory.new(self)
    end

    def specs
      Resources::Spec.new(self)
    end

    def orders
      Resources::Order.new(self)
    end

    def invoices
      Resources::Invoice.new(self)
    end

    def tracking
      Resources::Tracking.new(self)
    end

    def payment_profiles
      Resources::PaymentProfile.new(self)
    end

    def cross_references
      Resources::CrossReference.new(self)
    end

    def returns
      Resources::Return.new(self)
    end

    def days_in_transit
      Resources::DaysInTransit.new(self)
    end

    def get(path, params = {})
      request(:get, path, params)
    end

    def post(path, body = {})
      request(:post, path, body)
    end

    def put(path, body = {})
      request(:put, path, body)
    end

    def delete(path, params = {})
      request(:delete, path, params)
    end

    private

    def request(method, path, payload = {})
      response = connection.public_send(method) do |req|
        req.url path
        req.params[:mediatype] = config.media_type
        if %i[post put].include?(method)
          req.headers["Content-Type"] = "application/json"
          req.body = JSON.generate(payload)
        else
          payload.each { |k, v| req.params[k.to_s] = v }
        end
      end

      handle_response(response)
    end

    def connection
      @connection ||= Faraday.new(url: config.base_url) do |f|
        f.request :authorization, :basic, config.account_number, config.api_key
        f.response :json
        f.adapter Faraday.default_adapter
      end
    end

    def handle_response(response)
      case response.status
      when 200..299
        body = response.body
        case body
        when Array
          body.map { |item| Resource.new(item) }
        when Hash
          Resource.new(body)
        else
          body
        end
      when 400
        raise BadRequestError.new(error_message(response), status: response.status, body: response.body)
      when 401
        raise AuthenticationError.new("Invalid credentials", status: response.status, body: response.body)
      when 404
        raise NotFoundError.new(error_message(response), status: response.status, body: response.body)
      when 429
        raise RateLimitError.new("Rate limit exceeded", status: response.status, body: response.body)
      else
        raise ServerError.new(error_message(response), status: response.status, body: response.body)
      end
    end

    def error_message(response)
      body = response.body
      if body.is_a?(Hash)
        body["message"] || body["errors"]&.map { |e| e["message"] }&.join(", ") || "API error"
      else
        "API error (#{response.status})"
      end
    end
  end
end
