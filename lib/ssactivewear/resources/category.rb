# frozen_string_literal: true

module Ssactivewear
  module Resources
    class Category < Base
      def list(**params)
        get("categories/", params)
      end

      def find(id, **params)
        get("categories/#{id}", params)
      end
    end
  end
end
