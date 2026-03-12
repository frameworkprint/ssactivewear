# frozen_string_literal: true

module Ssactivewear
  module Resources
    class Tracking < Base
      def list(**params)
        get("tracking/", params)
      end

      def find(id, **params)
        get("tracking/#{id}", params)
      end
    end
  end
end
