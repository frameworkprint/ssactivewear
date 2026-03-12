# frozen_string_literal: true

module Ssactivewear
  module Resources
    class Brand < Base
      def list(**params)
        get("brands/", params)
      end

      def find(id, **params)
        get("brands/#{id}", params)
      end
    end
  end
end
