# frozen_string_literal: true

module Ssactivewear
  class Error < StandardError; end

  class ConfigurationError < Error; end

  class ApiError < Error
    attr_reader :status, :body

    def initialize(message = nil, status: nil, body: nil)
      @status = status
      @body = body
      super(message)
    end
  end

  class BadRequestError < ApiError; end

  class AuthenticationError < ApiError; end

  class NotFoundError < ApiError; end

  class RateLimitError < ApiError; end

  class ServerError < ApiError; end
end
