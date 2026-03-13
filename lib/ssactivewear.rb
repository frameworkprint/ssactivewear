# frozen_string_literal: true

require_relative "ssactivewear/version"
require_relative "ssactivewear/configuration"
require_relative "ssactivewear/error"
require_relative "ssactivewear/resource"
require_relative "ssactivewear/resources/base"
require_relative "ssactivewear/resources/category"
require_relative "ssactivewear/resources/style"
require_relative "ssactivewear/resources/product"
require_relative "ssactivewear/resources/brand"
require_relative "ssactivewear/resources/inventory"
require_relative "ssactivewear/resources/spec"
require_relative "ssactivewear/resources/order"
require_relative "ssactivewear/resources/invoice"
require_relative "ssactivewear/resources/tracking"
require_relative "ssactivewear/resources/payment_profile"
require_relative "ssactivewear/resources/cross_reference"
require_relative "ssactivewear/resources/return"
require_relative "ssactivewear/resources/days_in_transit"
require_relative "ssactivewear/client"

module Ssactivewear
  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end

    def client
      Client.new
    end

    def reset!
      @configuration = Configuration.new
    end
  end
end
