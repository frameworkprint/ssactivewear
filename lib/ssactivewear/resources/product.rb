# frozen_string_literal: true

module Ssactivewear
  module Resources
    class Product < Base
      def list(**params)
        get("products/", params)
      end

      def find(id, **params)
        get("products/#{id}", params)
      end
    end
  end
end
