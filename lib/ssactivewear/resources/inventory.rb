# frozen_string_literal: true

module Ssactivewear
  module Resources
    class Inventory < Base
      def list(**params)
        get("inventory/", params)
      end

      def find(id, **params)
        get("inventory/#{id}", params)
      end
    end
  end
end
